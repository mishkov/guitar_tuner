import 'package:flutter/cupertino.dart';
import 'package:guitar_tuner/gui/drawing_text.dart';

class MiddleFrequencyDeviation extends DrawingText {
  double _text;
  MiddleFrequencyDeviation(Canvas canvas, Size size, this._text)
      : super(canvas, size);

  @override
  double get fontSize => 36;

  @override
  Offset get offset => Offset((size.width / 2) - (painter.width / 2), 46);

  @override
  FontWeight get fontWeight => FontWeight.w600;

  @override
  String get text => _text.round().toString();
}
