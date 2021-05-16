import 'package:flutter/material.dart';

abstract class SideLabel {
  var canvas;
  var size;

  SideLabel(Canvas this.canvas, Size this.size);

  TextStyle get style => TextStyle(
        color: Color(0xFF2B2024),
        fontSize: 36,
        fontFamily: 'Josefin Sans',
      );

  TextSpan get span;

  double get minLayoutWidth => 50.0;

  TextPainter get painter => TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(
          minWidth: minLayoutWidth,
          maxWidth: size.width,
        );

  Offset get offset;

  void draw() => painter.paint(canvas, offset);
}
