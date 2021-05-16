import 'package:flutter/material.dart';
import 'package:guitar_tuner/interface/tune_route/scale_value/side_label.dart';

class LabelAtRight extends SideLabel {
  LabelAtRight(Canvas canvas, Size size) : super(canvas, size);

  TextSpan get span => TextSpan(
        text: '#',
        style: style,
      );

  Offset get offset => Offset(size.width - painter.width - 30, 139);
}
