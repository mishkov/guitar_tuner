import 'package:flutter/material.dart';

class LabelInBottomCenter {
  var canvas;
  var size;
  var deviationInHz;

  LabelInBottomCenter(
      Canvas this.canvas, Size this.size, double this.deviationInHz);

  TextStyle get style => TextStyle(
        color: Color(0xFF2B2024),
        fontSize: 18,
        fontFamily: 'Josefin Sans',
        fontWeight: FontWeight.w600,
      );

  String get toneLevel {
    if (deviationInHz < -5.0) {
      return 'too low';
    } else if (deviationInHz < -2.0) {
      return 'low';
    } else if (deviationInHz < 2.0) {
      return 'good';
    } else if (deviationInHz < 5.0) {
      return 'high';
    } else {
      return 'too high';
    }
  }

  TextSpan get span => TextSpan(
        text: toneLevel,
        style: style,
      );

  double get minLayoutWidth => 50.0;

  TextPainter get painter => TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(
          minWidth: minLayoutWidth,
          maxWidth: size.width,
        );

  Offset get offset => Offset((size.width / 2) - (painter.width / 2), 86);

  void draw() => painter.paint(canvas, offset);
}
