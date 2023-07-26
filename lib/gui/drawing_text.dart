import 'package:flutter/material.dart';
import 'package:guitar_tuner/gui/drawing_object.dart';

abstract class DrawingText extends DrawingObject {
  DrawingText(Canvas canvas, Size size) : super(canvas, size);

  @protected
  String get text;

  @protected
  double get fontSize;

  @protected
  Offset get offset;

  @protected
  FontWeight get fontWeight;

  @protected
  Color get color => Color(0xFF2B2024);

  @protected
  TextPainter get painter => TextPainter(
        text: _span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(
          minWidth: _minLayoutWidth,
          maxWidth: size.width,
        );

  TextSpan get _span => TextSpan(
        text: text,
        style: _style,
      );

  TextStyle get _style => TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'Josefin Sans',
      );

  double get _minLayoutWidth => 50.0;

  @override
  void draw() => painter.paint(canvas, offset);
}
