import 'package:flutter/cupertino.dart';

import '../../services/note_tuner.dart';
import '../drawing_object.dart';
import 'winder.dart';

class Winders extends DrawingObject {
  Map<Note, Winder> _winders;

  Winders(Canvas canvas, Size size, Note tunningNote) : super(canvas, size) {
    _winders = {
      Note.e1: Winder(canvas, size, Offset(125, 182)),
      Note.b: Winder(canvas, size, Offset(124, 122)),
      Note.g: Winder(canvas, size, Offset(130, 62)),
      Note.d: Winder(canvas, size, Offset(33, 62)),
      Note.A: Winder(canvas, size, Offset(36, 122)),
      Note.E: Winder(canvas, size, Offset(37, 182)),
    };
    _winders[tunningNote].activate();
  }

  @override
  void draw() => _winders.forEach(
        (key, value) => value.draw(),
      );
}
