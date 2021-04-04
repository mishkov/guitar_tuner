import 'package:flutter/material.dart';
import 'package:guitar_tuner/interface/tune_route/scale/background/cap.dart';

class LeftCap extends Cap {
  LeftCap(Canvas canvas, Size size) : super(canvas, size);

  Offset get _leftTopCorner => Offset(
        0,
        super.height,
      );

  Offset get _rightBottomCorner => _leftTopCorner.translate(
        arcWidth,
        cornerRadius,
      );

  @override
  void initPath() => path = Path()..addRRect(bounds);

  @override
  RRect get bounds => RRect.fromRectAndCorners(
        Rect.fromPoints(
          _leftTopCorner,
          _rightBottomCorner,
        ),
        bottomLeft: Radius.circular(cornerRadius),
        bottomRight: Radius.circular(cornerRadius),
      );
}
