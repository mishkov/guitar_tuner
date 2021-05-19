import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guitar_tuner/gui/figure.dart';

class Scale extends Figure {
  double _deviationInPercent;

  Scale(Canvas canvas, Size size, this._deviationInPercent)
      : super(canvas, size);

  @override
  Paint get bodyPaint => Paint()
    ..shader = _gradient.createShader(_bounds)
    ..style = PaintingStyle.stroke
    ..strokeWidth = _scaleWidth;

  SweepGradient get _gradient => SweepGradient(
        startAngle: math.min(_startAngle, _startAngle + _sweepAngle),
        endAngle: math.max(_startAngle, _startAngle + _sweepAngle),
        tileMode: TileMode.repeated,
        colors: [
          _startGradientColor,
          _endGradientColor,
        ],
      );

  Color get _startGradientColor =>
      _sweepAngle.isNegative ? _darkerColor : _lighterColor;

  Color get _endGradientColor =>
      _sweepAngle.isNegative ? _lighterColor : _darkerColor;

  Color get _darkerColor => Color(0xFFA80038);

  Color get _lighterColor => Color(0xFFFD0054);

  double get _scaleWidth {
    const ratio = 0.9249;
    return _radius - (_radius * ratio);
  }

  @override
  Path get path => Path()..addArc(_bounds, _startAngle, _sweepAngle);

  Rect get _bounds => Rect.fromCircle(
        center: _center,
        radius: _radius,
      );

  Offset get _center => Offset(
        size.width / 2,
        size.width / 2,
      );

  double get _radius {
    const ratio = 0.91149676;
    return (size.width / 2) * ratio;
  }

  double get _startAngle => math.pi * 1.5;

  double get _sweepAngle => (math.pi / 2) * _deviationInPercent;

  @override
  void draw() => canvas.drawPath(path, bodyPaint);
}
