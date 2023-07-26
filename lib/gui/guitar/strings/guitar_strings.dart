import 'dart:ui';

import 'package:guitar_tuner/gui/guitar/strings/sixth_string.dart';

import '../../../services/note_tuner.dart';
import '../../drawing_object.dart';
import 'fifth_string.dart';
import 'first_string.dart';
import 'fourth_string.dart';
import 'guitar_string.dart';
import 'second_string.dart';
import 'third_string.dart';

class GuitarStrings extends DrawingObject {
  Map<Note, GuitarString>? _strings;

  GuitarStrings(Canvas canvas, Size size, Note tunningNote)
      : super(canvas, size) {
    _strings = {
      Note.e1: FirstString(canvas, size),
      Note.b: SecondString(canvas, size),
      Note.g: ThirdString(canvas, size),
      Note.d: FourthString(canvas, size),
      Note.A: FifthString(canvas, size),
      Note.E: SixthString(canvas, size),
    };

    _strings![tunningNote]!.activate();
  }

  @override
  void draw() => _strings!.forEach(
        (key, value) => value.draw(),
      );
}
