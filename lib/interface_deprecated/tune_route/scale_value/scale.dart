import 'dart:math' as math show pi, min, max;

import 'package:flutter/material.dart';

// TODO: данный класс нуждается в рефакторинге, так как он определенно
// нарушает принцип DRY, потому что похожие геттеры находятся в
// абстрактном классе ScaleBackgroundFigure
class Scale {
  var canvas;
  var size;
  var deviationInPercentTween;
  var tickerProvider;
  var sweepAngleAnimation;

  Scale(Canvas this.canvas, Size this.size, Tween this.deviationInPercentTween,
      TickerProvider this.tickerProvider);

  Tween get sweepTween =>
      Tween<double>(begin: previousSweepAngle, end: newSweepAngle);

  Duration get animationDuration => const Duration(seconds: 2);

  AnimationController get sweepAngleAnimationController =>
      AnimationController(duration: animationDuration, vsync: tickerProvider);

  double get startAngle => math.pi * 1.5;

  double get previousSweepAngle =>
      (math.pi / 2) * deviationInPercentTween.begin;
  double get newSweepAngle => (math.pi / 2) * deviationInPercentTween.end;

  Path get path =>
      Path()..addArc(bounds, startAngle, sweepAngleAnimation.value);

  Rect get bounds => Rect.fromCircle(
        center: center,
        radius: radius,
      );

  Offset get center => Offset(
        size.width / 2,
        size.width / 2,
      );

  double get radius => height - (backgroundArcWidth / 2);

  double get height => size.width / 2;

  double get backgroundArcWidth {
    const ratio = 0.1769;
    return height * ratio;
  }

  Color get startGradientColor => Color(0xFFA80038);
  Color get endGradientColor => Color(0xFFFD0054);

  SweepGradient get gradient => SweepGradient(
        startAngle:
            math.min(startAngle, startAngle + sweepAngleAnimation.value),
        endAngle: math.max(startAngle, startAngle + sweepAngleAnimation.value),
        tileMode: TileMode.repeated,
        colors: [
          startGradientColor,
          endGradientColor,
        ],
      );

  double get arcWidth => backgroundArcWidth * 0.4;

  Paint get paint => Paint()
    ..shader = gradient.createShader(bounds)
    ..strokeCap = StrokeCap.butt
    ..style = PaintingStyle.stroke
    ..strokeWidth = arcWidth;

  void draw() {
    initAnimation();
    canvas.drawPath(path, paint);
  }

  void initAnimation() {
    sweepAngleAnimation = sweepTween.animate(sweepAngleAnimationController)
      ..addListener(() => tickerProvider.setState(() {}));
    sweepAngleAnimationController.forward();
  }
}
