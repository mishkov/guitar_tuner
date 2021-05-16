import 'package:flutter/material.dart';
import 'package:guitar_tuner/services/note_tuner.dart';

import 'guitar_painter.dart';

class Guitar extends StatefulWidget {
  final Note _selectedPeg = Note.e1;
  final Function(Note peg) _pegChangedListener;

  Guitar(this._pegChangedListener);

  Note get selectedPeg => _selectedPeg;

  @override
  State<StatefulWidget> createState() => _GuitarState();
}

class _GuitarState extends State<Guitar> {
  @override
  Widget build(BuildContext context) {
    final canvasSize = Size(218.6, 534);

    return GestureDetector(
      onTapDown: _onTap,
      child: CustomPaint(
        size: canvasSize,
        painter: GuitarPainter(widget._selectedPeg),
      ),
    );
  }

  void _onTap(TapDownDetails details) {
    // тут мы определяем область нажатия
    // изменяем выбранный колок

    widget._pegChangedListener(widget._selectedPeg);
  }
}
