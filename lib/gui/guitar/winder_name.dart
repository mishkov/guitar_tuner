import 'dart:ui';

import '../drawing_text.dart';

class WinderName extends DrawingText {
  bool _isTunning = false;
  Offset _offset;
  String _text;

  WinderName(Canvas canvas, Size size, this._text, this._offset)
      : super(canvas, size);

  void activate() => _isTunning = true;

  @override
  double get fontSize => 36;

  @override
  FontWeight get fontWeight => _isTunning ? FontWeight.bold : FontWeight.w400;

  @override
  Offset get offset => _offset;

  @override
  String get text => _text;

  @override
  Color get color => _isTunning ? _activatedColor : super.color;

  Color get _activatedColor => Color(0xFFFD0054);
}
