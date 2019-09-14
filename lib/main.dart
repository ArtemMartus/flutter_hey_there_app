import 'package:flutter/material.dart';

import 'HomePage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hey There App',
      home: Scaffold(body: HomePage()),
    );
  }
}
