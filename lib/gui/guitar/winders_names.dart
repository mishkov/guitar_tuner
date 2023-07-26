import 'dart:ui';

import 'package:guitar_tuner/gui/drawing_object.dart';
import 'package:guitar_tuner/services/note_tuner.dart';

import 'winder_name.dart';

class WindersNames extends DrawingObject {
  Map<Note, WinderName>? _windersNames;

  WindersNames(Canvas canvas, Size size, Note tunningNote) : super(canvas, size) {
    _windersNames = {
      Note.e1: WinderName(canvas, size, 'E', Offset(size.width + 12, 197)),
      Note.b: WinderName(canvas, size, 'B', Offset(size.width + 12, 136)),
      Note.g: WinderName(canvas, size, 'G', Offset(size.width + 12, 75)),
      Note.d: WinderName(canvas, size, 'D', Offset(-64, 75)),
      Note.A: WinderName(canvas, size, 'A', Offset(-64, 136)),
      Note.E: WinderName(canvas, size, 'E', Offset(-64, 197)),
    };

    _windersNames![tunningNote]!.activate();
  }

  @override
  void draw() => _windersNames!.forEach((key, value) => value.draw());
}
