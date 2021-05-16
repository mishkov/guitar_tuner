import 'package:flutter/material.dart';
import 'package:guitar_tuner/services/note_tuner.dart';

class Guitar extends StatefulWidget {
  final Function(Note peg) _pegChangedListener;

  Guitar(this._pegChangedListener);

  @override
  State<StatefulWidget> createState() => _GuitarState();
}

class _GuitarState extends State<Guitar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
