import 'dart:ui';

import 'package:guitar_tuner/gui/drawing_text.dart';

class ImmutableTextAtLeftEndOfUnderLay extends DrawingText {
  ImmutableTextAtLeftEndOfUnderLay(Canvas canvas, Size size)
      : super(canvas, size);

  @override
  double get fontSize => 36;

  @override
  Offset get offset => Offset(26, 132);

  @override
  FontWeight get fontWeight => FontWeight.w400;

  @override
  String get text => 'b';
}
