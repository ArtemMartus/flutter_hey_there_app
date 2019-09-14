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
          _notify(value, context);
          setState(_updateColor);
        }
      },
      onDoubleTap: () {
        switch (_colorGenerator.colorType) {
          case ColorTemperature.cold:
            _colorGenerator.colorType = ColorTemperature.warm;
            break;

          case ColorTemperature.warm:
            _colorGenerator.colorType = ColorTemperature.shadeOfGrey;
            break;

          case ColorTemperature.shadeOfGrey:
            _colorGenerator.colorType = ColorTemperature.cold;
            break;
        }
        _notify(_colorGenerator.colorType, context);
        setState(_updateColor);
      },
    );
  }

  void _updateColor() {
    _colorGenerator.updateColors();
    _color = _colorGenerator.color;
    _textStyle = TextStyle(color: _colorGenerator.contrasting, fontSize: 36.0);
  }

  _notify(ColorTemperature value, context) {
    String text;
    switch (value) {
      case ColorTemperature.cold:
        text = 'Cold colors';
        break;
      case ColorTemperature.warm:
        text = 'Warm colors';
        break;
      case ColorTemperature.shadeOfGrey:
        text = 'Grey colors';
        break;
    }
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 350),
    ));
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
