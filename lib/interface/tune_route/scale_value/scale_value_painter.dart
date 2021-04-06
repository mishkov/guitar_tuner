import 'package:flutter/material.dart';
import 'package:guitar_tuner/interface/tune_route/scale_value/scale_value.dart';

class ScaleValuePainter extends CustomPainter {
  final note;
  final frequency;

  ScaleValuePainter(this.note, this.frequency);

  @override
  void paint(Canvas canvas, Size size) {
    var scaleValue = ScaleValue(canvas, size, note, frequency);

    scaleValue.draw();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
