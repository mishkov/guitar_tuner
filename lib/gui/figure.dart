import 'dart:ui';

import 'package:meta/meta.dart';

import 'drawing_object.dart';

abstract class Figure extends DrawingObject {
  Figure(Canvas canvas, Size size) : super(canvas, size);

  @protected
  Path get path;
  @protected
  Paint get bodyPaint;
}
