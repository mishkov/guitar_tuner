import 'package:flutter/material.dart';
import 'package:guitar_tuner/interface/tune_route/scale_value/lable_at_left.dart';
import 'package:guitar_tuner/interface/tune_route/scale_value/lable_at_right.dart';

import 'label_in_bottom_center.dart';
import 'label_in_top_center.dart';

class ScaleText {
  var labelAtLeft;
  var labelAtRight;
  var labelInTopCenter;
  var labelInBottomCenter;

  ScaleText(Canvas canvas, Size size, double deviationInHz)
      : labelInTopCenter = LabelInTopCenter(canvas, size, deviationInHz),
        labelAtLeft = LabelAtLeft(canvas, size),
        labelAtRight = LabelAtRight(canvas, size),
        labelInBottomCenter = LabelInBottomCenter(canvas, size, deviationInHz);

  void draw() {
    labelAtLeft.draw();
    labelAtRight.draw();
    labelInTopCenter.draw();
    labelInBottomCenter.draw();
  }
}
