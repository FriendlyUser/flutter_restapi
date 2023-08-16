import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simpsonsviewer/types.dart';
import 'package:simpsonsviewer/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simpson Characters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Simpson Characters'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<RelatedTopic> characters = [];
  List<RelatedTopic> filteredCharacters = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCharacters();
    searchController.addListener(() {
      filterCharacters();
    });
  }

  filterCharacters() {
    List<RelatedTopic> tmpList = [];
    tmpList.addAll(characters);
    if(searchController.text.isNotEmpty) {
      tmpList.retainWhere((character) => character.fullName.toLowerCase().contains(searchController.text.toLowerCase()));
    }
    setState(() {
      filteredCharacters = tmpList;
    });
  }

  fetchCharacters() async {
    var response = await http.get(
      Uri.parse('https://api.jsonbin.io/v3/b/64dd31fa8e4aa6225ed10c55'),
      headers: {
        'Content-Type': 'application/json',
        'X-Master-Key': r"$2b$10$WQO9z7/PmRRHQ4JeXpqdj.X9n6Lh06FluuAn/Ejd.BIOPyL4mfTQ.", 
      }
    );
    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode(response.body);
        final relatedTopics = data['record']['RelatedTopics'] as List;
        List<RelatedTopic> mappedCharacters = [];
        List<RelatedTopic> topics = relatedTopics.map((topic) {
          var fullName = getFirstAndLastName(topic);
          final topicMap = topic as Map<String, dynamic>;
          var newTopic = RelatedTopic(
            firstUrl: topicMap['FirstURL'] as String, 
            fullName: fullName,
            icon: AvailableImage.fromJson(topicMap['Icon'] as Map<String, dynamic>),
            result: topicMap['Result'] as String,
            text: topicMap['Text'] as String,
          );
          mappedCharacters.add(newTopic);
          return newTopic;
        }).toList();
        characters = mappedCharacters;
        filteredCharacters = characters;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))
                )
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: filteredCharacters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredCharacters[index].fullName),
            subtitle: Text("Do something here"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailScreen(character: filteredCharacters[index])),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final RelatedTopic character;

  DetailScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.fullName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image.network(character.icon.url, errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://cdn.playeternalreturn.com/event/season1/firstseason/sec03/ico_notebook.png',
              );
            },),
            Text(character.result),
          ],
        ),
      ),
    );
  }
}