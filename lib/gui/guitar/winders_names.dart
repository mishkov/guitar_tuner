import 'dart:ui';

import 'package:guitar_tuner/gui/drawing_object.dart';
import 'package:guitar_tuner/services/note_tuner.dart';

class WindersNames extends DrawingObject {
  Note _tunningNote;

  WindersNames(Canvas canvas, Size size, this._tunningNote)
      : super(canvas, size);

  @override
  void draw() {
    // TODO: implement draw
  }
}
