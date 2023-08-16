import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simpsonsviewer/types.dart';

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
  dynamic characters = {};

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  fetchCharacters() async {
    var response = await http.get(Uri.parse('http://api.duckduckgo.com/?q=simpsons+characters&format=json'));
    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode(response.body);
        final relatedTopics = data['RelatedTopics'] as List;
        final topics = relatedTopics.map((topic) {
          return RelatedTopic(
            firstUrl: topic['FirstURL'] as String,
            icon: AvailableImage.fromJson(topic['Icon'] as Map<String, dynamic>), 
            result: topic['Result'] as String,
            text: topic['Text'] as String,
          );
        }).toList();
        characters = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(characters[index]['firstName'] + ' ' + characters[index]['lastName']),
            subtitle: Text(characters[index]['quote']),
          );
        },
      ),
    );
  }
}
