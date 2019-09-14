import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

// types of random color we'd like to get
enum ColorTemperature { cold, warm, shadeOfGrey }

class ColorGenerator {
  final _rnd = Random();
  var colorType = ColorTemperature.shadeOfGrey;

  // we don't want to set colors from the outside
  Color _backgroundColor;
  Color _contrastingColor;

  Color get color => _backgroundColor;

  Color get contrasting => _contrastingColor;

  // Use HSV to get cold and warm colors
  updateColors() {
    switch (colorType) {
      // 150-270 is cold colors hue angle range
      case ColorTemperature.cold:
        final hue = (150.0 + _rnd.nextInt(120)) % 360;
        final contrastingHue = (hue + 180) % 360;
        final saturation = (_rnd.nextInt(20) + 80.0) / 100;
        final light = (_rnd.nextInt(20) + 80.0) / 100;

        _backgroundColor =
            HSVColor.fromAHSV(1.0, hue, saturation, light).toColor();
        _contrastingColor =
            HSVColor.fromAHSV(1.0, contrastingHue, 1.0, 1.0).toColor();
        break;

      // 335-50 is warm colors hue angle range
      case ColorTemperature.warm:
        final hue = (335.0 + _rnd.nextInt(75)) % 360;
        final contrastingHue = (hue + 180) % 360;

        final saturation = (_rnd.nextInt(20) + 80.0) / 100;
        final light = (_rnd.nextInt(20) + 80.0) / 100;

        _backgroundColor =
            HSVColor.fromAHSV(1.0, hue, saturation, light).toColor();
        _contrastingColor =
            HSVColor.fromAHSV(1.0, contrastingHue, 1.0, 1.0).toColor();
        break;

      // For grey colors we use all random RGB model
      case ColorTemperature.shadeOfGrey:
        var contrastingShade = 1 + _rnd.nextInt(8);
        var shade = (5 + contrastingShade) % 9 + 1;

        _backgroundColor = Colors.grey[shade * 100];
        _contrastingColor = Colors.grey[contrastingShade * 100];
        break;

      default:
        //We don't really want to handle null color type
        throw Exception("Invalid color type");
    }
  }
}
