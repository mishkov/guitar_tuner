import 'package:flutter/material.dart';
import 'package:guitar_tuner/gui/guitar/guitar_neck.dart';
import 'package:guitar_tuner/services/note_tuner.dart';

class GuitarPainter extends CustomPainter {
  Note _selectedPeg;

  GuitarPainter(this._selectedPeg);

  @override
  void paint(Canvas canvas, Size size) {
    GuitarNeck(canvas, size).draw();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
