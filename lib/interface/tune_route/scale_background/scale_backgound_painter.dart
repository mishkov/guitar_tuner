import 'package:flutter/material.dart';

import 'scale_background.dart';

class ScaleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var scaleBackground = ScaleBackground(canvas, size);
    scaleBackground.draw();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
