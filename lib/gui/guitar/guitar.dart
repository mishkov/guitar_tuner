import 'package:flutter/material.dart';
import 'package:guitar_tuner/services/note_tuner.dart';

import 'guitar_painter.dart';

class Guitar extends StatefulWidget {
  final Function(Note peg) _noteChangedListener;

  Guitar(this._noteChangedListener);

  @override
  State<StatefulWidget> createState() => _GuitarState();
}

class _GuitarState extends State<Guitar> {
  final _canvasSize = Size(218.6, 534.0);
  var _screenWidth;
  var _selectedNote = Note.e1;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapDown: _onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.maxFinite,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: CustomPaint(
            size: _canvasSize,
            painter: GuitarPainter(_selectedNote),
          ),
        ),
      ),
    );
  }

  void _onTap(TapDownDetails details) {
    // TODO: Refactor this SHIT CODE!!!
    var fourWinder = Rect.fromLTWH(0, 67, _screenWidth / 2, 52);
    var fifthWinder = fourWinder.shift(Offset(0, 62));
    var sixthWinder = fifthWinder.shift(Offset(0, 62));
    var firstWinder = sixthWinder.shift(Offset(_screenWidth / 2, 0));
    var secondWinder = fifthWinder.shift(Offset(_screenWidth / 2, 0));
    var thirdWinder = fourWinder.shift(Offset(_screenWidth / 2, 0));

    final pointer = details.localPosition;
    if (firstWinder.contains(pointer)) {
      _selectedNote = Note.e1;
    } else if (secondWinder.contains(pointer)) {
      _selectedNote = Note.b;
    } else if (thirdWinder.contains(pointer)) {
      _selectedNote = Note.g;
    } else if (fourWinder.contains(pointer)) {
      _selectedNote = Note.d;
    } else if (fifthWinder.contains(pointer)) {
      _selectedNote = Note.A;
    } else if (sixthWinder.contains(pointer)) {
      _selectedNote = Note.E;
    } else {
      return;
    }

    print(_selectedNote);

    setState(() => widget._noteChangedListener(_selectedNote));
  }
}
