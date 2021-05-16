import 'package:flutter/material.dart';

class LabelInTopCenter {
  var canvas;
  var size;
  var deviationInHz;

  LabelInTopCenter(
      Canvas this.canvas, Size this.size, double this.deviationInHz);

  TextStyle get style => TextStyle(
        color: Color(0xFF2B2024),
        fontSize: 36,
        fontFamily: 'Josefin Sans',
        fontWeight: FontWeight.w600,
      );

  TextSpan get span => TextSpan(
        text: deviationInHz.round().toString(),
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

  Offset get offset => Offset((size.width / 2) - (painter.width / 2), 46);

  void draw() => painter.paint(canvas, offset);
}
