import 'package:flutter/material.dart';
import 'package:guitar_tuner/gui/guitar/guitar_neck.dart';
import 'package:guitar_tuner/gui/guitar/headstock_text.dart';
import 'package:guitar_tuner/services/note_tuner.dart';

import 'strings/guitar_strings.dart';
import 'winders.dart';
import 'winders_names.dart';

class GuitarPainter extends CustomPainter {
  Note _selectedNote;

  GuitarPainter(this._selectedNote);

  @override
  void paint(Canvas canvas, Size size) {
    GuitarStrings(canvas, size, _selectedNote).draw();
    GuitarNeck(canvas, size).draw();
    HeadstockText(canvas, size).draw();
    Winders(canvas, size, _selectedNote).draw();
    WindersNames(canvas, size, _selectedNote).draw();
  }

  @override
  bool shouldRepaint(covariant GuitarPainter oldDelegate) {
    return _selectedNote != oldDelegate._selectedNote;
  }
}
