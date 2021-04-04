import 'package:flutter/material.dart';

import 'package:guitar_tuner/interface/tune_route/scale/background/scale_background.dart';

class ScaleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var scaleBackground = ScaleBackground(canvas, size);
    scaleBackground.draw();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
