import 'dart:ui';

import 'package:meta/meta.dart';

import '../../drawing_object.dart';

abstract class GuitarString extends DrawingObject {
  bool _isTunning = false;

  GuitarString(Canvas canvas, Size size) : super(canvas, size);

  void activate() => _isTunning = true;

  Paint get topPartPaint => Paint()
    ..strokeWidth = 4
    ..style = PaintingStyle.stroke
    ..shader = Gradient.linear(
      _startOffset,
      _midOffset,
      [
        _startGradientColor,
        _endGradientColor,
      ],
    );

  Paint get bottomPartPaint => Paint()
    ..strokeWidth = 4
    ..style = PaintingStyle.stroke
    ..shader = Gradient.linear(
      _midOffset,
      _endOffset,
      [
        _endGradientColor,
        _startGradientColor,
      ],
    );

  Offset get _startOffset => Offset(0, 0);

  Offset get _midOffset => Offset(0, 282);

  Offset get _endOffset => Offset(0, 537);

  Color get _startGradientColor => Color(0xFFA80038);

  Color get _endGradientColor => Color(0xFFFD0054);

  @protected
  Path get topPartPath;

  @protected
  Path get bottomPartPath;

  @override
  void draw() {
    if (!_isTunning) {
      return;
    }

    canvas.drawPath(topPartPath, topPartPaint);
    canvas.drawPath(bottomPartPath, bottomPartPaint);
  }
}
