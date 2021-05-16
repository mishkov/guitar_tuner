import 'package:flutter/material.dart';
import 'package:guitar_tuner/interface/tune_route/scale_value/side_label.dart';

class LabelAtLeft extends SideLabel {
  LabelAtLeft(Canvas canvas, Size size) : super(canvas, size);

  TextSpan get span => TextSpan(
        text: 'b',
        style: style,
      );

  Offset get offset => Offset(30, 139);
}
