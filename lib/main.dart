import 'dart:math' as math;
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Guitar Tuner",
      debugShowCheckedModeBanner: false,
      home: TuneRoute(),
    );
  }
}

class TuneRoute extends StatefulWidget {
  @override
  TuneRouteState createState() => TuneRouteState();
}

class TuneRouteState extends State<TuneRoute> {
  double frequency;
  String note;
  bool isRecording;
  DrawableRoot tuningForkSvg;

  FlutterFft flutterFft = new FlutterFft();

  @override
  void initState() {
    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    super.initState();
    _async();
    _fetchAssets();
  }

  void _fetchAssets() async {
    var tuningForkStirng =
        await rootBundle.loadString('assets/tuning_fork.svg');
    var tuningFork =
        await svg.fromSvgString(tuningForkStirng, tuningForkStirng);
    setState(() => tuningForkSvg = tuningFork);
  }

  @override
  Widget build(BuildContext context) {
    const scaleMargin = 37.0;
    final scaleWidth = MediaQuery.of(context).size.width - scaleMargin;
    final scaleHeight = scaleWidth / 2;
    var statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        color: const Color(0xFFDDDDDD),
        child: Container(
          margin: EdgeInsets.only(
            left: scaleMargin,
            top: scaleMargin + statusBarHeight,
            right: scaleMargin,
            bottom: scaleMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CustomPaint(
                size: Size(scaleWidth, scaleHeight),
                painter: ScalePainter(1),
              ),
              isRecording
                  ? Text(
                      "Current note: $note",
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    )
                  : Text(
                      "None yet",
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
              isRecording
                  ? Text(
                      "Current frequency: ${frequency.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    )
                  : Text(
                      "None yet",
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _async() async {
    print("starting...");
    await flutterFft.startRecorder();
    setState(() => isRecording = flutterFft.getIsRecording);
    flutterFft.onRecorderStateChanged.listen(
      (data) => {
        setState(
          () => {
            frequency = data[1],
            note = data[2],
          },
        ),
        flutterFft.setNote = note,
        flutterFft.setFrequency = frequency,
      },
    );
  }
}

class ScalePainter extends CustomPainter {
  double _progress;

  ScalePainter(double progress) {
    if (progress < 0 || 1 < progress) {
      throw Exception('Progress should be in range 0..1!');
    } else {
      _progress = progress;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawsScaleBackground(canvas, size);

    // Draw progress line
    final progressScaleWidth = scaleBackgroundWidth * 0.4;
    var progressScaleRadius = scaleBackgroundRadius;

    const startValueAngle = math.pi;
    const maxValueAngle = math.pi;
    const startGradientColor = Color(0xFFFD0054);
    const endGradientColor = Color(0xFFA80038);
    final gradient = new SweepGradient(
      startAngle: startValueAngle,
      endAngle: startValueAngle + maxValueAngle * _progress,
      tileMode: TileMode.repeated,
      colors: [
        startGradientColor,
        endGradientColor,
      ],
    );
    var processScaleBouns = Rect.fromCircle(
      center: scaleCenter,
      radius: progressScaleRadius,
    );
    final progressScalePaint = new Paint()
      ..shader = gradient.createShader(processScaleBouns)
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = progressScaleWidth;

    canvas.drawArc(processScaleBouns, startValueAngle,
        maxValueAngle * _progress, false, progressScalePaint);
  }

  void drawsScaleBackground(Canvas canvas, Size size) {
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
    var whiteShadowPaint = Paint()
      ..color = Color(0x66FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = scaleBackgroundWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

    var scaleBackgroundArcBounds =
        Rect.fromCircle(center: scaleCenter, radius: scaleBackgroundRadius);
    var scaleBackgroundArc = Path()
      ..addArc(scaleBackgroundArcBounds, math.pi, math.pi);
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
  }

  @override
  bool shouldRepaint(ScalePainter oldDelegate) => true;
}
