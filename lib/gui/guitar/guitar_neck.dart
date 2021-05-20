import 'dart:ui';

import 'package:guitar_tuner/gui/neumorphism_figure.dart';

import 'paths/guitar_neck_path.dart';

class GuitarNeck extends NeumorphismFigure {
  GuitarNeck(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get path => guitarNeckPath(size);
}
