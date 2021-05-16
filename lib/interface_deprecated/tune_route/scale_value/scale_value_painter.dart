import 'package:flutter/material.dart';
import 'package:guitar_tuner/interface/tune_route/scale_value/scale_value.dart';

class ScaleValuePainter extends CustomPainter {
  final note;
  final frequencyTween;
  final tickerProvider;

  ScaleValuePainter(this.note, this.frequencyTween, this.tickerProvider);

  @override
  void paint(Canvas canvas, Size size) {
    var scaleValue =
        ScaleValue(canvas, size, note, frequencyTween, tickerProvider);

    scaleValue.draw();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
