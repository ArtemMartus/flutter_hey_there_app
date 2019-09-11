import 'package:flutter/material.dart';

import 'HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hey There App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: HomePage()),
    );
  }
}
