import 'package:flutter/material.dart';

class UnderLayPath extends Path {
  UnderLayPath(Size size) : super() {
    lineTo(size.width * 0.98, size.height);
    cubicTo(size.width, size.height, size.width, size.height * 0.98, size.width,
        size.height * 0.95);
    cubicTo(size.width, size.height * 0.7, size.width * 0.94,
        size.height * 0.47, size.width * 0.85, size.height * 0.29);
    cubicTo(size.width * 0.76, size.height * 0.11, size.width * 0.63, 0,
        size.width / 2, 0);
    cubicTo(size.width * 0.37, 0, size.width * 0.24, size.height * 0.11,
        size.width * 0.15, size.height * 0.29);
    cubicTo(size.width * 0.06, size.height * 0.47, size.width * 0.01,
        size.height * 0.7, 0, size.height * 0.95);
    cubicTo(0, size.height * 0.98, size.width * 0.01, size.height,
        size.width * 0.02, size.height);
    cubicTo(size.width * 0.02, size.height, size.width * 0.06, size.height,
        size.width * 0.06, size.height);
    cubicTo(size.width * 0.08, size.height, size.width * 0.09,
        size.height * 0.98, size.width * 0.09, size.height * 0.95);
    cubicTo(size.width * 0.09, size.height * 0.75, size.width * 0.14,
        size.height * 0.56, size.width / 5, size.height * 0.42);
    cubicTo(size.width * 0.29, size.height * 0.26, size.width * 0.39,
        size.height * 0.18, size.width / 2, size.height * 0.18);
    cubicTo(size.width * 0.61, size.height * 0.18, size.width * 0.71,
        size.height * 0.26, size.width * 0.79, size.height * 0.42);
    cubicTo(size.width * 0.86, size.height * 0.56, size.width * 0.91,
        size.height * 0.75, size.width * 0.91, size.height * 0.95);
    cubicTo(size.width * 0.91, size.height * 0.98, size.width * 0.92,
        size.height, size.width * 0.94, size.height);
    cubicTo(size.width * 0.94, size.height, size.width * 0.98, size.height,
        size.width * 0.98, size.height);
    cubicTo(size.width * 0.98, size.height, size.width * 0.98, size.height,
        size.width * 0.98, size.height);
  }

  @override
  noSuchMethod(Invocation invocation) {
    print('Oh! Fuckin SHIT!!!!');
    return super.noSuchMethod(invocation);
  }
}
