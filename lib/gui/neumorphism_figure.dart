import 'dart:ui';

import 'package:flutter/material.dart';

import 'figure.dart';

abstract class NeumorphismFigure extends Figure {
  NeumorphismFigure(Canvas canvas, Size size) : super(canvas, size);

  @override
  void draw() {
    _drawBlackShadow();
    _drawWhiteShadow();
    _drawBody();
  }

  void _drawBlackShadow() =>
      canvas.drawPath(path.shift(_blackShadowOffset), _blackShadowPaint);

  Offset get _blackShadowOffset => Offset(4, 4);

  Paint get _blackShadowPaint => Paint()
    ..color = _blackShadowColor
    ..style = PaintingStyle.fill
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, _shadowBlurSigma);

  Color get _blackShadowColor => Color(0x26000000);

  void _drawWhiteShadow() =>
      canvas.drawPath(path.shift(_whiteShadowOffset), _whiteShadowPaint);

  Offset get _whiteShadowOffset => Offset(-4, -4);

  Paint get _whiteShadowPaint => Paint()
    ..color = _whiteShadowColor
    ..style = PaintingStyle.fill
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, _shadowBlurSigma);

  Color get _whiteShadowColor => Color(0x66FFFFFF);

  double get _shadowBlurSigma => 6.0;

  void _drawBody() => canvas.drawPath(path, bodyPaint);

  Paint get bodyPaint => Paint()
    ..color = _bodyColor
    ..style = PaintingStyle.fill;

  Color get _bodyColor => Color(0xFFDDDDDD);
}
