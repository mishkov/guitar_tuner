import 'package:flutter/material.dart';

class Test extends CustomPainter {
  final tickerPainter;

  Test(TickerProvider this.tickerPainter);

  @override
  void paint(Canvas canvas, Size size) {
    var controller = AnimationController(
        duration: const Duration(seconds: 2), vsync: tickerPainter);
    var tween = Tween<double>(begin: -200, end: 0);
    var i = tween.animate(controller);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
