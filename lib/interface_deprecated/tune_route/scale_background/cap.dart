import 'package:flutter/material.dart';
import 'scale_background_figure.dart';

abstract class Cap extends ScaleBackgroundFigure {
  Cap(Canvas canvas, Size size) : super(canvas, size);

  double get cornerRadius => 8.0;

  @override
  void initPaint() => paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill
    ..strokeWidth = arcWidth;

  @override
  void initBlackShadowPaint() => blackShadowPaint = Paint()
    ..color = blackShadowColor
    ..style = PaintingStyle.fill
    ..strokeWidth = arcWidth
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurSigma);

  @override
  void initWhiteShadowPaint() => whiteShadowPaint = Paint()
    ..color = whiteShadowColor
    ..style = PaintingStyle.fill
    ..strokeWidth = arcWidth
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurSigma);
}
