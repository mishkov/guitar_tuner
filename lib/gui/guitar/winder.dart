import 'dart:ui';

import '../neumorphism_figure.dart';
import 'paths/winder_path.dart';

class Winder extends NeumorphismFigure {
  bool _isTunning = false;
  Offset _offset;

  Winder(Canvas canvas, Size size, this._offset) : super(canvas, size);

  void activate() => _isTunning = true;

  @override
  Paint get bodyPaint => _isTunning ? _activatedPaint : super.bodyPaint;

  Paint get _activatedPaint => Paint()
    ..shader = Gradient.linear(
      _startOffset,
      _endOffset,
      [
        _startGradientColor,
        _endGradientColor,
      ],
    );

  Offset get _startOffset => _offset;

  Offset get _endOffset => _offset.translate(30, 30);

  Color get _startGradientColor => Color(0xFFFD0054);

  Color get _endGradientColor => Color(0xFFA80038);

  @override
  Path get path => winderPath().shift(_offset);
}
