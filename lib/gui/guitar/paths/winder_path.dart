import 'package:flutter/material.dart';

final _winderPath = Path()
  ..addOval(
    Rect.fromCircle(
      center: Offset(29, 29),
      radius: 15,
    ),
  );

Path winderPath() {
  return _winderPath;
}
