import 'package:flutter/material.dart';
import 'package:guitar_tuner/interface/neumorphism_figure.dart';

abstract class ScaleBackgroundFigure implements NeumorphismFigure {
  var canvas;
  var size;
  var path;
  var paint;
  var blackShadowPaint;
  var whiteShadowPaint;

  ScaleBackgroundFigure(Canvas this.canvas, Size this.size) {
    initPath();
    initPaint();
    initBlackShadowPaint();
    initWhiteShadowPaint();
  }

  void initPath();

  void initPaint();

  void initBlackShadowPaint();

  void initWhiteShadowPaint();

  Color get color => Color(0xFFDDDDDD);

  Color get blackShadowColor => Color(0x26000000);

  Color get whiteShadowColor => Color(0x66FFFFFF);

  double get shadowBlurSigma => 10.0;

  double get height => size.width / 2;

  double get arcWidth {
    const ratio = 0.1769;
    return height * ratio;
  }

  get bounds;

  @override
  void drawBody() {
    canvas.drawPath(path, paint);
  }

  @override
  void drawBlackShadow() {
    canvas.drawPath(path, blackShadowPaint);
  }

  @override
  void drawWhiteShadow() {
    canvas.drawPath(path, whiteShadowPaint);
  }
}
