import 'package:flutter/material.dart';

import 'jsonn.dart';
import 'jsonn2.dart';
import 'jsonn3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('JSON'),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        // backgroundColor: Colors.greenAccent[100],
        body: const Jsonn(),
        // body: const Jsonn2(),
        // body: const Jsonn3(),
      ),
    );
  }
}

