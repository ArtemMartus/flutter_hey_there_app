import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hey_there_app/ColorGenerator.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _colorGenerator = ColorGenerator();
  Color _color;
  TextStyle _textStyle;

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
          child: Text(
            'Hey there!',
            style: _textStyle,
          ),
        ),
      ),
      onLongPressStart: (details) async {
        final pos = RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx,
            details.globalPosition.dy);
        final value = await showMenu(
            context: context,
            items: <PopupMenuEntry>[
              _popupMenuItem('Warm', ColorTemperature.warm),
              _popupMenuItem('Cold', ColorTemperature.cold),
              _popupMenuItem('Grey', ColorTemperature.shadeOfGrey),
            ],
            position: pos) as ColorTemperature;
        print("Current:${_colorGenerator.colorType} new: $value");

        if (value != null) {
          _colorGenerator.colorType = value;
          setState(() => _updateColor);
        }
      },
    );
  }

  void _updateColor() {
    _colorGenerator.updateColors();
    _color = _colorGenerator.color;
    _textStyle = TextStyle(color: _colorGenerator.contrasting, fontSize: 36.0);
  }

  Widget _popupMenuItem(String title, ColorTemperature type) {
    return PopupMenuItem(
      value: type,
      child: Row(
        children: <Widget>[
          Text(title),
          Spacer(
            flex: 2,
          ),
          Container(
            child: type == _colorGenerator.colorType ? Icon(Icons.check) : null,
          ),
          Spacer()
        ],
      ),
    );
  }
}
