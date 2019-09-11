import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color;
  final _rnd = math.Random();

  _updateColor() {
    _color = Color(_rnd.nextInt(0xffffffff));
  }

  @override
  void initState() {
    super.initState();
    _updateColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(_updateColor),
      child: Container(
        color: _color,
        child: Center(
          child: Text('Hey there!'),
        ),
      ),
    );
  }
}
