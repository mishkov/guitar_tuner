import 'package:flutter/material.dart';
import 'package:guitar_tuner/interface/tune_route/scale/background/arc.dart';
import 'package:guitar_tuner/interface/tune_route/scale/background/left_cap.dart';
import 'package:guitar_tuner/interface/tune_route/scale/background/right_cap.dart';

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
