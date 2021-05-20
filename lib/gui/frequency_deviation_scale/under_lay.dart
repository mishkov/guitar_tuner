import 'dart:ui';

import 'package:guitar_tuner/gui/neumorphism_figure.dart';

import 'paths/under_lay_path.dart';

class UnderLay extends NeumorphismFigure {
  UnderLay(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get path => underLayPath(size);
}
