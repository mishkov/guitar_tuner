import 'dart:ui';

import 'package:guitar_tuner/gui/drawing_object.dart';
import 'package:guitar_tuner/gui/drawing_text.dart';

class MiddleText extends DrawingText {
  String _text;

  MiddleText(Canvas canvas, Size size, this._text) : super(canvas, size);

  @override
  double get fontSize => 18;

  @override
  Offset get offset => Offset((size.width / 2) - (painter.width / 2), 86);

  @override
  FontWeight get fontWeight => FontWeight.w600;

  @override
  String get text => _text;
}
