import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'scale_background_figure.dart';

class Arc extends ScaleBackgroundFigure {
  Arc(Canvas canvas, size) : super(canvas, size);

  @override
  void initPath() {
    final startAngle = math.pi;
    final sweepAngle = math.pi;
    path = Path()..addArc(bounds, startAngle, sweepAngle);
  }

  @override
  void initPaint() => paint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = arcWidth;

  @override
  void initBlackShadowPaint() => blackShadowPaint = Paint()
    ..color = blackShadowColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = arcWidth
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurSigma);

  @override
  void initWhiteShadowPaint() => whiteShadowPaint = Paint()
    ..color = whiteShadowColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = arcWidth
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurSigma);

  @override
  Rect get bounds => Rect.fromCircle(center: _center, radius: _radius);

  Offset get _center => Offset(
        size.width / 2,
        size.width / 2,
      );

  double get _radius => height - (arcWidth / 2);
}
