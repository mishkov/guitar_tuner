import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'neumorphism_figure.dart';

class ScaleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var scaleBackground = _ScaleBackground(canvas, size);
    scaleBackground.draw():
    _canvas = canvas;
    _size = size;
    _drawWhiteShadow();
    _drawBlackShadow();
    _drawArc();
    _drawLeftCap();
    _drawRightCap();

    var scaleCenter = Offset(
      size.width / 2,
      size.width / 2,
    );

    final scaleBackgroundHeight = size.width / 2;
    final scaleBackgroundWidth = scaleBackgroundHeight * 0.1769;
    final scaleBackgroundRadius =
        scaleBackgroundHeight - (scaleBackgroundWidth / 2);
    const scaleBackgroundCapRadius = 8.0;
    const scaleBackgroundColor = Color(0xFFDDDDDD);

    var leftTopCornerOfLeftScaleCap = Offset(
      0,
      scaleBackgroundHeight,
    );
    var rightBottomCornerOfLeftScaleCap = leftTopCornerOfLeftScaleCap.translate(
      scaleBackgroundWidth,
      scaleBackgroundCapRadius,
    );

    var leftCapOfScaleBackground = RRect.fromRectAndCorners(
      Rect.fromPoints(
        leftTopCornerOfLeftScaleCap,
        rightBottomCornerOfLeftScaleCap,
      ),
      bottomLeft: Radius.circular(scaleBackgroundCapRadius),
      bottomRight: Radius.circular(scaleBackgroundCapRadius),
    );
    var rightBackgoundScaleCap = leftCapOfScaleBackground.shift(Offset(
      2 * scaleBackgroundRadius,
      0,
    ));

    var scaleBackgroundCapsPaint = Paint()
      ..color = scaleBackgroundColor
      ..style = PaintingStyle.fill;
    var scaleBackgroundArcPaint = Paint()
      ..color = scaleBackgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = scaleBackgroundWidth;
    var blackShadowPaint = Paint()
      ..color = Color(0x26000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = scaleBackgroundWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

    var scaleBackgroundArcBounds =
        Rect.fromCircle(center: scaleCenter, radius: scaleBackgroundRadius);
    
    var scaleBackgroundCaps = Path()
      ..addRRect(leftCapOfScaleBackground)
      ..addRRect(rightBackgoundScaleCap);

    canvas.drawPath(scaleBackgroundArc.shift(Offset(4, 4)), blackShadowPaint);
    canvas.drawPath(scaleBackgroundCaps.shift(Offset(4, 4)), blackShadowPaint);
    canvas.drawPath(scaleBackgroundArc.shift(Offset(-4, -4)), whiteShadowPaint);
    canvas.drawPath(
        scaleBackgroundCaps.shift(Offset(-4, -4)), whiteShadowPaint);
    canvas.drawPath(scaleBackgroundArc, scaleBackgroundArcPaint);
    canvas.drawPath(scaleBackgroundCaps, scaleBackgroundCapsPaint);

    _drawWhiteShadowForArc();
  }

  void drawWhiteShadow() {
    _drawWhiteShadowForArc();
    _drawWhiteShadowForLeftCap();
    _drawWhiteShadowForRightCap();
  }

  void _drawWhiteShadowForArc() {
    var arc = Path()
      ..addArc(scaleBackgroundArcBounds, math.pi, math.pi);
    _drawWhiteShadowFor(arc);
  }

  void _drawWhiteShadowForLeftCap() {
    var leftTopCorner = Offset(
      0,
      height,
    );
    var rightBottomCorner = leftTopCorner.translate(
      arcWidth,
      scaleBackgroundCapRadius,
    );
    var leftCapBounds = RRect.fromRectAndCorners(
      Rect.fromPoints(
        leftTopCornerOfLeftScaleCap,
        rightBottomCornerOfLeftScaleCap,
      ),
      bottomLeft: Radius.circular(scaleBackgroundCapRadius),
      bottomRight: Radius.circular(scaleBackgroundCapRadius),
    );
    var leftCap = Path()
      ..addArc(scaleBackgroundArcBounds, math.pi, math.pi);

    _drawWhiteShadowFor(arc);
  }

  double get height => _size.height / 2;

  double get arcWidth { 
    const ratio = 0.1769;
    return _size.width * ratio;
  }




  void _drawWhiteShadowFor(Path path) {
    const blurSigma = 10.0;
    var whiteShadowPaint = Paint()
      ..color = Color(0x66FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = _arcWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    var shadowOffset(Offset(-4, -4));

    _canvas.drawPath(path.shift(), whiteShadowPaint);
  }

  double get _arcWidth {
    const ratio = 0.1769;
    return _arcHeight * ratio;
  }

  double get _arcHeight => _size.width / 2;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ScaleBackground {
  final _canvas;
  final _size;

  _ScaleBackground(this._canvas, this._size);

  void draw() {
    _arc.drawWhiteShaadow();
    _leftCap.drawWhiteShadow();
    _rightCap.drawWhiteShadow();

    _arc.drawBlackShadow();
    _leftCap.drawBlackShadow();
    _rightCap.drawBlackShadow();

    _arc.draw();
    _leftCap.draw();
    _rightCap.draw();
  }
}

class _Arc extends NeumorphismFigure {
  var _canvas;
  var _size;
  var _path;
  var _paint;
  var _blackShadowPaint;
  var _whiteShadowPaint;

  _Arc(Canvas this._canvas, Size this._size) : super(_canvas, _size) {
      _initPath();
      _initPaint();
      _initBlackShadowPaint();
      _initWhiteShadowPaint();
  }

  void _initPath() {
    final startAngle = math.pi;
    final sweepAngle = math.pi;
    _path = Path()..addArc(_bounds, startAngle, sweepAngle);
  }

  void _initPaint() => _paint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _arcWidth;

  void _initBlackShadowPaint() => _blackShadowPaint = Paint()
      ..color = _blackShadowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _arcWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, _shadowBlurSigma);

  void _initWhiteShadowPaint() => _whiteShadowPaint = Paint()
    ..color = _whiteShadowColor
    ..style = PaintingStyle.stroke
      ..strokeWidth = _arcWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, _shadowBlurSigma);

  Color get _color => Color(0xFFDDDDDD);

  Color get _blackShadowColor => Color(0x26000000);

  Color get _whiteShadowColor => Color(0x66FFFFFF);

  double get _shadowBlurSigma => 8.0;

  Rect get _bounds => Rect.fromCircle(center: _center, radius: _radius);

  Offset get _center => Offset(
      _size.width / 2,
      _size.width / 2,
    );

  double get _radius => _height - (_arcWidth / 2);

  double get _height => _size.width / 2;

  double get _arcWidth {
    const ratio = 0.1769;
    return _height * ratio;
  }

  @override
  void draw() {
    _canvas.drawPath(_path, _paint);
  }

  @override
  void drawBlackShadow() {
    _canvas.drawPath(_path, _blackShadowPaint);
  }

  @override
  void drawWhiteShadow() {
    // TODO: implement drawWhiteShadow
  }}

