import 'package:flutter/material.dart';
import 'package:simpsonsviewer/screens.dart';

class MyApp extends StatelessWidget {
  
  final String flavor;
  const MyApp({Key? key, required this.flavor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simpson Characters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Simpson Characters', flavor: flavor),
    );
  }
}