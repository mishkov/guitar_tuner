import 'dart:ui';

import 'package:guitar_tuner/gui/drawing_text.dart';

class ImmutableTextAtRightEndOfUnderLay extends DrawingText {
  ImmutableTextAtRightEndOfUnderLay(Canvas canvas, Size size)
      : super(canvas, size);

  @override
  double get fontSize => 36;

  @override
  Offset get offset => Offset(size.width - painter.width - 26, 132);

  @override
  FontWeight get fontWeight => FontWeight.w400;

  @override
  String get text => '#';
}
