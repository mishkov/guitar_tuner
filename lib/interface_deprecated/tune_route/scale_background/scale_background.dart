import 'package:flutter/material.dart';
import 'arc.dart';
import 'left_cap.dart';
import 'right_cap.dart';

class ScaleBackground {
  var _arc;
  var _leftCap;
  var _rightCap;

  ScaleBackground(Canvas canvas, Size size)
      : _arc = Arc(canvas, size),
        _leftCap = LeftCap(canvas, size),
        _rightCap = RightCap(canvas, size);

  void draw() {
    _drawWhiteShadow();
    _drawBlackShadow();
    _drawBody();
  }

  void _drawWhiteShadow() {
    _arc.drawWhiteShadow();
    _leftCap.drawWhiteShadow();
    _rightCap.drawWhiteShadow();
  }

  void _drawBlackShadow() {
    _arc.drawBlackShadow();
    _leftCap.drawBlackShadow();
    _rightCap.drawBlackShadow();
  }

  void _drawBody() {
    _arc.drawBody();
    _leftCap.drawBody();
    _rightCap.drawBody();
  }
}
