import 'package:flutter/cupertino.dart';
import 'package:guitar_tuner/gui/frequency_deviation_scale/immutable_text_at_left_end_of_under_lay.dart';
import 'package:guitar_tuner/gui/frequency_deviation_scale/immutable_text_at_right_end_of_under_lay.dart';
import 'package:guitar_tuner/gui/frequency_deviation_scale/middle_frequency_deviation.dart';

import 'middle_text.dart';
import 'scale.dart';
import 'under_lay.dart';

class FrequencyDeviationScalePainter extends CustomPainter {
  double _deviationInHz;
  double _deviationInPercent;
  String _deviationInText;

  FrequencyDeviationScalePainter(
    this._deviationInHz,
    this._deviationInPercent,
    this._deviationInText,
  );

  @override
  void paint(Canvas canvas, Size size) {
    UnderLay(canvas, size).draw();
    ImmutableTextAtLeftEndOfUnderLay(canvas, size).draw();
    ImmutableTextAtRightEndOfUnderLay(canvas, size).draw();
    MiddleText(canvas, size, _deviationInText).draw();
    MiddleFrequencyDeviation(canvas, size, _deviationInHz).draw();
    if (_deviationInPercent != 0.0) {
      Scale(canvas, size, _deviationInPercent).draw();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
