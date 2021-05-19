import 'dart:ui';

import 'package:guitar_tuner/gui/drawing_text.dart';

class HeadstockText extends DrawingText {
  HeadstockText(Canvas canvas, Size size) : super(canvas, size);

  @override
  double get fontSize => 18;

  @override
  FontWeight get fontWeight => FontWeight.w400;

  @override
  Offset get offset => Offset((size.width / 2) - (painter.width / 2), 28);

  @override
  String get text => 'guitar tuner';
}
