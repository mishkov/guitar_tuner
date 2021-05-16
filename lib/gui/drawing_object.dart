import 'dart:ui';

import 'package:meta/meta.dart';

abstract class DrawingObject {
  @protected
  Canvas canvas;
  @protected
  Size size;

  DrawingObject(this.canvas, this.size);

  void draw();
}
