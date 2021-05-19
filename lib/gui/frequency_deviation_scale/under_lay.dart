import 'dart:ui';

import 'package:guitar_tuner/gui/neomorphism_figure.dart';

import 'paths/under_lay_path.dart';

class UnderLay extends NeomorphismFigure {
  UnderLay(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get path => UnderLayPath(size);
}
