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
        final hue = (150.0 + _rnd.nextInt(120)) % 350;
        final alpha = 1.0;
        final saturation = (_rnd.nextInt(20) + 80.0) / 100;
        final light = (_rnd.nextInt(20) + 80.0) / 100;

        _backgroundColor =
            HSVColor.fromAHSV(alpha, hue, saturation, light).toColor();
        _contrastingColor = HSVColor.fromAHSV(alpha, hue, 1.0, 0.5).toColor();
        break;

      // 335-50 is warm colors hue angle range
      case ColorTemperature.warm:
        final hue = (335.0 + _rnd.nextInt(75)) % 350;
        final alpha = 1.0;
        final saturation = (_rnd.nextInt(20) + 80.0) / 100;
        final light = (_rnd.nextInt(20) + 80.0) / 100;

        _backgroundColor =
            HSVColor.fromAHSV(alpha, hue, saturation, light).toColor();
        _contrastingColor = HSVColor.fromAHSV(alpha, hue, 1.0, 0.5).toColor();
        break;

      // For grey colors we use all random RGB model
      case ColorTemperature.shadeOfGrey:
        var contrastingShade = _rnd.nextInt(255);
        var shade = 255 - contrastingShade;

        _backgroundColor = Color.fromARGB(255, shade, shade, shade);
        _contrastingColor = Color.fromARGB(_rnd.nextInt(50) + 205,
            contrastingShade, contrastingShade, contrastingShade);
        break;

      default:
        //We don't really want to handle null color type
        throw Exception("Invalid color type");
    }
  }
}
