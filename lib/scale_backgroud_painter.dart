class ScaleBackgroundPainter extends CustomPainter {
  Canvas _canvas;
  Size _size;

  @override
  void paint(Canvas canvas, Size size) {
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
