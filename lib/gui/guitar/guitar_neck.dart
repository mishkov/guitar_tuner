import 'dart:ui';

import 'package:guitar_tuner/gui/neomorphism_figure.dart';

import 'paths/guitar_neck_path.dart';

class GuitarNeck extends NeomorphismFigure {
  GuitarNeck(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get path => GuitarNeckPath(size);
}
