import 'package:flutter/material.dart';
import 'package:guitar_tuner/interface/tune_route/scale/background/cap.dart';

class RightCap extends Cap {
  RightCap(Canvas canvas, Size size) : super(canvas, size);

  Offset get _leftTopCorner => Offset(
        size.width - arcWidth,
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
