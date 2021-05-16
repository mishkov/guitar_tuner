import 'package:flutter/material.dart';
import 'package:guitar_tuner/services/frequency_recorder.dart';
import 'package:guitar_tuner/services/note_tuner.dart';

import 'gui/frequency_deviation_scale/freqeuncy_deviation_scale.dart';
import 'gui/guitar/guitar.dart';

void main() {
  runApp(Application());
}

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

class TuneRouteState extends State<TuneRoute> with TickerProviderStateMixin {
  double _deviationInHz;
  double _deviationInPercent;
  String _deviationInText;
  Note _tunningNote = Note.e1;
  NoteTuner _noteTuner = NoteTuner();
  FrequencyRecorder _frequencyRecorder = FrequencyRecorder();
  Function(Note peg) _pegChangedListener;

  @override
  void initState() {
    _noteTuner.frequency = 0.0;
    _noteTuner.note = _tunningNote;

    setupDeviation();

    _frequencyRecorder.recordPeriod = Duration(milliseconds: 500);
    _frequencyRecorder.frequencyChangedListener = (frequency) {
      setState(() {
        _noteTuner.frequency = frequency;
        setupDeviation();
      });
    };

    _pegChangedListener = (note) {
      _noteTuner.note = note;
    };
    super.initState();
  }

  void setupDeviation() {
    _deviationInHz = _noteTuner.deviationInHz;
    _deviationInPercent = _noteTuner.deviationInPercent;
    _deviationInText = _noteTuner.deviationIntext;
  }

  @override
  Widget build(BuildContext context) {
    const scaleMargin = 37.0;
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
              FrequencyDeviationScale(
                _deviationInHz,
                _deviationInPercent,
                _deviationInText,
              ),
              Guitar(_pegChangedListener),
            ],
          ),
        ),
      ),
    );
  }
}

class testPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('Size: $size');
    Paint filling = Paint();
    Paint paint = Paint()
      ..color = Color(0x26000000)
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0);
    Path path = Path();

    // Path number 1

    filling.color = Color(0xffDDDDDD);
    path = Path();
    path.lineTo(size.width, size.height * 0.32);
    path.cubicTo(size.width, size.height * 0.35, size.width, size.height * 0.35,
        size.width, size.height * 0.36);
    path.cubicTo(size.width * 0.98, size.height * 0.37, size.width * 0.98,
        size.height * 0.37, size.width * 0.96, size.height * 0.38);
    path.cubicTo(size.width * 0.96, size.height * 0.38, size.width * 0.95,
        size.height * 0.38, size.width * 0.94, size.height * 0.38);
    path.cubicTo(size.width * 0.93, size.height * 0.38, size.width * 0.93,
        size.height * 0.38, size.width * 0.92, size.height * 0.38);
    path.cubicTo(size.width * 0.91, size.height * 0.37, size.width * 0.91,
        size.height * 0.37, size.width * 0.9, size.height * 0.36);
    path.cubicTo(size.width * 0.9, size.height * 0.36, size.width * 0.9,
        size.height * 0.35, size.width * 0.9, size.height * 0.34);
    path.cubicTo(size.width * 0.9, size.height * 0.34, size.width * 0.9,
        size.height / 3, size.width * 0.9, size.height / 3);
    path.cubicTo(size.width * 0.9, size.height / 3, size.width * 0.89,
        size.height / 3, size.width * 0.89, size.height / 3);
    path.cubicTo(size.width * 0.89, size.height / 3, size.width * 0.86,
        size.height / 3, size.width * 0.86, size.height / 3);
    path.cubicTo(size.width * 0.86, size.height / 3, size.width * 0.86,
        size.height / 3, size.width * 0.86, size.height / 3);
    path.cubicTo(size.width * 0.86, size.height / 3, size.width * 0.85,
        size.height * 0.37, size.width * 0.85, size.height * 0.37);
    path.cubicTo(size.width * 0.84, size.height * 0.45, size.width * 0.84,
        size.height * 0.46, size.width * 0.84, size.height * 0.48);
    path.cubicTo(size.width * 0.84, size.height * 0.49, size.width * 0.84,
        size.height * 0.49, size.width * 0.84, size.height * 0.49);
    path.cubicTo(size.width * 0.84, size.height * 0.49, size.width * 0.84,
        size.height / 2, size.width * 0.84, size.height / 2);
    path.cubicTo(size.width * 0.84, size.height / 2, size.width * 0.86,
        size.height / 2, size.width * 0.86, size.height / 2);
    path.cubicTo(size.width * 0.86, size.height / 2, size.width * 0.88,
        size.height / 2, size.width * 0.88, size.height / 2);
    path.cubicTo(size.width * 0.88, size.height / 2, size.width * 0.88,
        size.height * 0.49, size.width * 0.88, size.height * 0.49);
    path.cubicTo(size.width * 0.88, size.height * 0.48, size.width * 0.88,
        size.height * 0.48, size.width * 0.89, size.height * 0.47);
    path.cubicTo(size.width * 0.89, size.height * 0.46, size.width * 0.9,
        size.height * 0.46, size.width * 0.91, size.height * 0.45);
    path.cubicTo(size.width * 0.92, size.height * 0.45, size.width * 0.92,
        size.height * 0.45, size.width * 0.93, size.height * 0.45);
    path.cubicTo(size.width * 0.94, size.height * 0.45, size.width * 0.94,
        size.height * 0.45, size.width * 0.95, size.height * 0.45);
    path.cubicTo(size.width * 0.96, size.height * 0.46, size.width * 0.97,
        size.height * 0.47, size.width * 0.98, size.height * 0.48);
    path.cubicTo(size.width * 0.98, size.height * 0.49, size.width * 0.98,
        size.height * 0.55, size.width * 0.98, size.height * 0.56);
    path.cubicTo(size.width * 0.97, size.height * 0.57, size.width * 0.97,
        size.height * 0.58, size.width * 0.95, size.height * 0.58);
    path.cubicTo(size.width * 0.92, size.height * 0.6, size.width * 0.88,
        size.height * 0.58, size.width * 0.88, size.height * 0.55);
    path.cubicTo(size.width * 0.88, size.height * 0.55, size.width * 0.88,
        size.height * 0.55, size.width * 0.88, size.height * 0.55);
    path.cubicTo(size.width * 0.88, size.height * 0.55, size.width * 0.86,
        size.height * 0.55, size.width * 0.86, size.height * 0.55);
    path.cubicTo(size.width * 0.86, size.height * 0.55, size.width * 0.83,
        size.height * 0.55, size.width * 0.83, size.height * 0.55);
    path.cubicTo(size.width * 0.83, size.height * 0.55, size.width * 0.83,
        size.height * 0.62, size.width * 0.83, size.height * 0.62);
    path.cubicTo(size.width * 0.83, size.height * 0.66, size.width * 0.83,
        size.height * 0.69, size.width * 0.83, size.height * 0.69);
    path.cubicTo(size.width * 0.84, size.height * 0.7, size.width * 0.87,
        size.height * 0.69, size.width * 0.88, size.height * 0.69);
    path.cubicTo(size.width * 0.88, size.height * 0.69, size.width * 0.88,
        size.height * 0.69, size.width * 0.88, size.height * 0.69);
    path.cubicTo(size.width * 0.88, size.height * 0.69, size.width * 0.88,
        size.height * 0.69, size.width * 0.88, size.height * 0.69);
    path.cubicTo(size.width * 0.88, size.height * 0.68, size.width * 0.88,
        size.height * 0.66, size.width * 0.89, size.height * 0.66);
    path.cubicTo(size.width * 0.92, size.height * 0.64, size.width * 0.95,
        size.height * 0.64, size.width * 0.97, size.height * 0.66);
    path.cubicTo(size.width * 0.97, size.height * 0.67, size.width * 0.97,
        size.height * 0.67, size.width * 0.97, size.height * 0.67);
    path.cubicTo(size.width * 0.97, size.height * 0.67, size.width * 0.97,
        size.height * 0.69, size.width * 0.98, size.height * 0.71);
    path.cubicTo(size.width * 0.98, size.height * 0.76, size.width * 0.98,
        size.height * 0.76, size.width * 0.97, size.height * 0.77);
    path.cubicTo(size.width * 0.96, size.height * 0.78, size.width * 0.95,
        size.height * 0.78, size.width * 0.93, size.height * 0.78);
    path.cubicTo(size.width * 0.92, size.height * 0.78, size.width * 0.92,
        size.height * 0.78, size.width * 0.91, size.height * 0.78);
    path.cubicTo(size.width * 0.9, size.height * 0.77, size.width * 0.89,
        size.height * 0.76, size.width * 0.89, size.height * 0.75);
    path.cubicTo(size.width * 0.88, size.height * 0.74, size.width * 0.88,
        size.height * 0.74, size.width * 0.88, size.height * 0.74);
    path.cubicTo(size.width * 0.88, size.height * 0.74, size.width * 0.84,
        size.height * 0.74, size.width * 0.84, size.height * 0.74);
    path.cubicTo(size.width * 0.84, size.height * 0.74, size.width * 0.84,
        size.height * 0.76, size.width * 0.84, size.height * 0.77);
    path.cubicTo(size.width * 0.84, size.height * 0.77, size.width * 0.84,
        size.height * 0.79, size.width * 0.84, size.height * 0.79);
    path.cubicTo(size.width * 0.84, size.height * 0.79, size.width * 0.82,
        size.height * 0.8, size.width * 0.82, size.height * 0.8);
    path.cubicTo(size.width * 0.78, size.height * 0.83, size.width * 0.75,
        size.height * 0.87, size.width * 0.74, size.height * 0.92);
    path.cubicTo(size.width * 0.73, size.height * 0.94, size.width * 0.73,
        size.height * 0.97, size.width * 0.73, size.height);
    path.cubicTo(size.width * 0.73, size.height, size.width * 0.73, size.height,
        size.width * 0.73, size.height);
    path.cubicTo(size.width * 0.73, size.height, size.width * 0.71, size.height,
        size.width * 0.71, size.height);
    path.cubicTo(size.width * 0.7, size.height, size.width * 0.7, size.height,
        size.width * 0.7, size.height);
    path.cubicTo(size.width * 0.7, size.height, size.width * 0.66,
        size.height * 0.75, size.width * 0.66, size.height * 0.75);
    path.cubicTo(size.width * 0.66, size.height * 0.75, size.width * 0.68,
        size.height * 0.76, size.width * 0.68, size.height * 0.76);
    path.cubicTo(size.width * 0.68, size.height * 0.76, size.width * 0.69,
        size.height * 0.76, size.width * 0.69, size.height * 0.76);
    path.cubicTo(size.width * 0.73, size.height * 0.77, size.width * 0.76,
        size.height * 0.74, size.width * 0.75, size.height * 0.71);
    path.cubicTo(size.width * 0.75, size.height * 0.7, size.width * 0.74,
        size.height * 0.69, size.width * 0.72, size.height * 0.68);
    path.cubicTo(size.width * 0.71, size.height * 0.68, size.width * 0.71,
        size.height * 0.68, size.width * 0.7, size.height * 0.68);
    path.cubicTo(size.width * 0.69, size.height * 0.68, size.width * 0.68,
        size.height * 0.68, size.width * 0.68, size.height * 0.68);
    path.cubicTo(size.width * 0.67, size.height * 0.69, size.width * 0.66,
        size.height * 0.7, size.width * 0.65, size.height * 0.7);
    path.cubicTo(size.width * 0.65, size.height * 0.7, size.width * 0.65,
        size.height * 0.71, size.width * 0.65, size.height * 0.71);
    path.cubicTo(size.width * 0.65, size.height * 0.71, size.width * 0.65,
        size.height * 0.69, size.width * 0.65, size.height * 0.69);
    path.cubicTo(size.width * 0.65, size.height * 0.69, size.width * 0.65,
        size.height * 0.66, size.width * 0.66, size.height * 0.62);
    path.cubicTo(size.width * 0.66, size.height * 0.58, size.width * 0.66,
        size.height * 0.55, size.width * 0.66, size.height * 0.55);
    path.cubicTo(size.width * 0.66, size.height * 0.55, size.width * 0.66,
        size.height * 0.55, size.width * 0.66, size.height * 0.55);
    path.cubicTo(size.width * 0.66, size.height * 0.55, size.width * 0.67,
        size.height * 0.55, size.width * 0.67, size.height * 0.55);
    path.cubicTo(size.width * 0.7, size.height * 0.56, size.width * 0.74,
        size.height * 0.55, size.width * 0.75, size.height * 0.52);
    path.cubicTo(size.width * 0.75, size.height / 2, size.width * 0.73,
        size.height * 0.47, size.width * 0.7, size.height * 0.47);
    path.cubicTo(size.width * 0.69, size.height * 0.47, size.width * 0.69,
        size.height * 0.48, size.width * 0.68, size.height * 0.48);
    path.cubicTo(size.width * 0.67, size.height * 0.49, size.width * 0.66,
        size.height / 2, size.width * 0.66, size.height * 0.48);
    path.cubicTo(size.width * 0.66, size.height * 0.48, size.width * 0.69,
        size.height * 0.35, size.width * 0.69, size.height * 0.35);
    path.cubicTo(size.width * 0.69, size.height * 0.35, size.width * 0.69,
        size.height * 0.35, size.width * 0.7, size.height * 0.35);
    path.cubicTo(size.width * 0.71, size.height * 0.36, size.width * 0.73,
        size.height * 0.36, size.width * 0.75, size.height * 0.35);
    path.cubicTo(size.width * 0.78, size.height * 0.34, size.width * 0.79,
        size.height * 0.3, size.width * 0.76, size.height * 0.28);
    path.cubicTo(size.width * 0.74, size.height * 0.26, size.width * 0.7,
        size.height * 0.27, size.width * 0.68, size.height * 0.29);
    path.cubicTo(size.width * 0.68, size.height * 0.3, size.width * 0.68,
        size.height * 0.31, size.width * 0.68, size.height * 0.32);
    path.cubicTo(size.width * 0.68, size.height * 0.32, size.width * 0.64,
        size.height * 0.44, size.width * 0.6, size.height * 0.66);
    path.cubicTo(size.width * 0.6, size.height * 0.66, size.width * 0.53,
        size.height, size.width * 0.53, size.height);
    path.cubicTo(size.width * 0.53, size.height, size.width / 2, size.height,
        size.width / 2, size.height);
    path.cubicTo(size.width / 2, size.height, size.width * 0.48, size.height,
        size.width * 0.48, size.height);
    path.cubicTo(size.width * 0.48, size.height, size.width * 0.48, size.height,
        size.width * 0.48, size.height);
    path.cubicTo(size.width * 0.48, size.height, size.width * 0.34,
        size.height * 0.32, size.width / 3, size.height * 0.31);
    path.cubicTo(size.width / 3, size.height * 0.27, size.width * 0.26,
        size.height * 0.26, size.width * 0.23, size.height * 0.29);
    path.cubicTo(size.width * 0.23, size.height * 0.3, size.width * 0.23,
        size.height * 0.3, size.width * 0.23, size.height * 0.31);
    path.cubicTo(size.width * 0.23, size.height * 0.32, size.width * 0.23,
        size.height * 0.32, size.width * 0.23, size.height / 3);
    path.cubicTo(size.width / 4, size.height * 0.35, size.width * 0.29,
        size.height * 0.36, size.width * 0.32, size.height * 0.34);
    path.cubicTo(size.width * 0.32, size.height * 0.34, size.width * 0.32,
        size.height * 0.34, size.width * 0.32, size.height * 0.34);
    path.cubicTo(size.width * 0.32, size.height * 0.34, size.width * 0.32,
        size.height * 0.34, size.width * 0.32, size.height * 0.34);
    path.cubicTo(size.width * 0.32, size.height * 0.35, size.width * 0.35,
        size.height * 0.49, size.width * 0.35, size.height * 0.49);
    path.cubicTo(size.width * 0.35, size.height * 0.49, size.width * 0.35,
        size.height * 0.49, size.width * 0.34, size.height * 0.48);
    path.cubicTo(size.width * 0.32, size.height * 0.47, size.width * 0.29,
        size.height * 0.47, size.width * 0.27, size.height * 0.49);
    path.cubicTo(size.width * 0.26, size.height * 0.49, size.width * 0.26,
        size.height * 0.49, size.width * 0.26, size.height / 2);
    path.cubicTo(size.width / 4, size.height / 2, size.width / 4,
        size.height * 0.51, size.width / 4, size.height * 0.52);
    path.cubicTo(size.width / 4, size.height * 0.53, size.width / 4,
        size.height * 0.53, size.width * 0.26, size.height * 0.53);
    path.cubicTo(size.width * 0.27, size.height * 0.56, size.width * 0.31,
        size.height * 0.57, size.width * 0.34, size.height * 0.55);
    path.cubicTo(size.width * 0.34, size.height * 0.55, size.width * 0.34,
        size.height * 0.55, size.width * 0.34, size.height * 0.55);
    path.cubicTo(size.width * 0.35, size.height * 0.55, size.width * 0.36,
        size.height * 0.69, size.width * 0.36, size.height * 0.69);
    path.cubicTo(size.width * 0.36, size.height * 0.69, size.width * 0.35,
        size.height * 0.69, size.width * 0.35, size.height * 0.69);
    path.cubicTo(size.width * 0.34, size.height * 0.68, size.width * 0.32,
        size.height * 0.68, size.width * 0.3, size.height * 0.68);
    path.cubicTo(size.width * 0.29, size.height * 0.69, size.width * 0.28,
        size.height * 0.69, size.width * 0.28, size.height * 0.7);
    path.cubicTo(size.width * 0.27, size.height * 0.71, size.width * 0.27,
        size.height * 0.71, size.width * 0.27, size.height * 0.72);
    path.cubicTo(size.width * 0.27, size.height * 0.73, size.width * 0.27,
        size.height * 0.73, size.width * 0.27, size.height * 0.74);
    path.cubicTo(size.width * 0.28, size.height * 0.76, size.width * 0.32,
        size.height * 0.77, size.width * 0.34, size.height * 0.76);
    path.cubicTo(size.width * 0.35, size.height * 0.76, size.width * 0.35,
        size.height * 0.76, size.width * 0.35, size.height * 0.76);
    path.cubicTo(size.width * 0.35, size.height * 0.76, size.width * 0.32,
        size.height, size.width * 0.32, size.height);
    path.cubicTo(size.width * 0.32, size.height, size.width * 0.32, size.height,
        size.width * 0.32, size.height);
    path.cubicTo(size.width * 0.32, size.height, size.width * 0.31, size.height,
        size.width * 0.31, size.height);
    path.cubicTo(size.width * 0.31, size.height, size.width * 0.3, size.height,
        size.width * 0.3, size.height);
    path.cubicTo(size.width * 0.3, size.height, size.width * 0.29, size.height,
        size.width * 0.29, size.height);
    path.cubicTo(size.width * 0.29, size.height * 0.97, size.width * 0.29,
        size.height * 0.96, size.width * 0.28, size.height * 0.94);
    path.cubicTo(size.width * 0.27, size.height * 0.89, size.width * 0.23,
        size.height * 0.84, size.width * 0.19, size.height * 0.79);
    path.cubicTo(size.width * 0.19, size.height * 0.79, size.width * 0.18,
        size.height * 0.78, size.width * 0.18, size.height * 0.78);
    path.cubicTo(size.width * 0.18, size.height * 0.78, size.width * 0.18,
        size.height * 0.77, size.width * 0.18, size.height * 0.77);
    path.cubicTo(size.width * 0.18, size.height * 0.76, size.width * 0.18,
        size.height * 0.75, size.width * 0.18, size.height * 0.75);
    path.cubicTo(size.width * 0.18, size.height * 0.75, size.width * 0.18,
        size.height * 0.74, size.width * 0.18, size.height * 0.74);
    path.cubicTo(size.width * 0.18, size.height * 0.74, size.width * 0.16,
        size.height * 0.74, size.width * 0.16, size.height * 0.74);
    path.cubicTo(size.width * 0.15, size.height * 0.74, size.width * 0.14,
        size.height * 0.74, size.width * 0.14, size.height * 0.74);
    path.cubicTo(size.width * 0.14, size.height * 0.74, size.width * 0.13,
        size.height * 0.74, size.width * 0.13, size.height * 0.74);
    path.cubicTo(size.width * 0.13, size.height * 0.74, size.width * 0.13,
        size.height * 0.75, size.width * 0.13, size.height * 0.75);
    path.cubicTo(size.width * 0.13, size.height * 0.76, size.width * 0.12,
        size.height * 0.76, size.width * 0.12, size.height * 0.77);
    path.cubicTo(size.width * 0.1, size.height * 0.78, size.width * 0.07,
        size.height * 0.78, size.width * 0.05, size.height * 0.77);
    path.cubicTo(size.width * 0.04, size.height * 0.76, size.width * 0.04,
        size.height * 0.76, size.width * 0.04, size.height * 0.75);
    path.cubicTo(size.width * 0.04, size.height * 0.74, size.width * 0.04,
        size.height * 0.67, size.width * 0.04, size.height * 0.67);
    path.cubicTo(size.width * 0.05, size.height * 0.66, size.width * 0.05,
        size.height * 0.65, size.width * 0.07, size.height * 0.65);
    path.cubicTo(size.width * 0.07, size.height * 0.64, size.width * 0.08,
        size.height * 0.64, size.width * 0.09, size.height * 0.64);
    path.cubicTo(size.width * 0.1, size.height * 0.64, size.width * 0.1,
        size.height * 0.64, size.width * 0.11, size.height * 0.65);
    path.cubicTo(size.width * 0.12, size.height * 0.65, size.width * 0.12,
        size.height * 0.65, size.width * 0.13, size.height * 0.66);
    path.cubicTo(size.width * 0.13, size.height * 0.67, size.width * 0.13,
        size.height * 0.67, size.width * 0.13, size.height * 0.68);
    path.cubicTo(size.width * 0.13, size.height * 0.68, size.width * 0.13,
        size.height * 0.69, size.width * 0.13, size.height * 0.69);
    path.cubicTo(size.width * 0.13, size.height * 0.69, size.width * 0.15,
        size.height * 0.69, size.width * 0.15, size.height * 0.69);
    path.cubicTo(size.width * 0.16, size.height * 0.69, size.width * 0.17,
        size.height * 0.69, size.width * 0.17, size.height * 0.69);
    path.cubicTo(size.width * 0.17, size.height * 0.69, size.width * 0.17,
        size.height * 0.63, size.width * 0.17, size.height * 0.57);
    path.cubicTo(size.width * 0.17, size.height * 0.57, size.width * 0.17,
        size.height * 0.54, size.width * 0.17, size.height * 0.54);
    path.cubicTo(size.width * 0.17, size.height * 0.54, size.width * 0.14,
        size.height * 0.54, size.width * 0.14, size.height * 0.54);
    path.cubicTo(size.width * 0.14, size.height * 0.54, size.width * 0.12,
        size.height * 0.54, size.width * 0.12, size.height * 0.54);
    path.cubicTo(size.width * 0.12, size.height * 0.54, size.width * 0.12,
        size.height * 0.55, size.width * 0.12, size.height * 0.55);
    path.cubicTo(size.width * 0.12, size.height * 0.56, size.width * 0.11,
        size.height * 0.58, size.width * 0.09, size.height * 0.58);
    path.cubicTo(size.width * 0.09, size.height * 0.59, size.width * 0.09,
        size.height * 0.59, size.width * 0.08, size.height * 0.59);
    path.cubicTo(size.width * 0.06, size.height * 0.59, size.width * 0.06,
        size.height * 0.59, size.width * 0.06, size.height * 0.58);
    path.cubicTo(size.width * 0.05, size.height * 0.58, size.width * 0.04,
        size.height * 0.57, size.width * 0.03, size.height * 0.57);
    path.cubicTo(size.width * 0.03, size.height * 0.57, size.width * 0.03,
        size.height * 0.56, size.width * 0.03, size.height * 0.56);
    path.cubicTo(size.width * 0.03, size.height * 0.56, size.width * 0.03,
        size.height * 0.52, size.width * 0.03, size.height * 0.52);
    path.cubicTo(size.width * 0.03, size.height * 0.52, size.width * 0.03,
        size.height * 0.47, size.width * 0.03, size.height * 0.47);
    path.cubicTo(size.width * 0.03, size.height * 0.47, size.width * 0.03,
        size.height * 0.47, size.width * 0.03, size.height * 0.47);
    path.cubicTo(size.width * 0.04, size.height * 0.46, size.width * 0.05,
        size.height * 0.46, size.width * 0.06, size.height * 0.45);
    path.cubicTo(size.width * 0.06, size.height * 0.45, size.width * 0.06,
        size.height * 0.45, size.width * 0.08, size.height * 0.45);
    path.cubicTo(size.width * 0.09, size.height * 0.45, size.width * 0.09,
        size.height * 0.45, size.width * 0.1, size.height * 0.45);
    path.cubicTo(size.width * 0.11, size.height * 0.46, size.width * 0.11,
        size.height * 0.46, size.width * 0.12, size.height * 0.47);
    path.cubicTo(size.width * 0.12, size.height * 0.47, size.width * 0.12,
        size.height * 0.48, size.width * 0.12, size.height * 0.49);
    path.cubicTo(size.width * 0.12, size.height * 0.49, size.width * 0.12,
        size.height * 0.49, size.width * 0.12, size.height * 0.49);
    path.cubicTo(size.width * 0.12, size.height * 0.49, size.width * 0.14,
        size.height * 0.49, size.width * 0.14, size.height * 0.49);
    path.cubicTo(size.width * 0.14, size.height * 0.49, size.width * 0.16,
        size.height * 0.49, size.width * 0.16, size.height * 0.49);
    path.cubicTo(size.width * 0.16, size.height * 0.49, size.width * 0.16,
        size.height * 0.48, size.width * 0.16, size.height * 0.48);
    path.cubicTo(size.width * 0.16, size.height * 0.47, size.width * 0.16,
        size.height * 0.46, size.width * 0.16, size.height * 0.45);
    path.cubicTo(size.width * 0.15, size.height * 0.41, size.width * 0.14,
        size.height * 0.34, size.width * 0.14, size.height / 3);
    path.cubicTo(size.width * 0.14, size.height / 3, size.width * 0.1,
        size.height * 0.34, size.width * 0.1, size.height * 0.34);
    path.cubicTo(size.width * 0.1, size.height * 0.34, size.width * 0.1,
        size.height * 0.34, size.width * 0.1, size.height * 0.35);
    path.cubicTo(size.width * 0.1, size.height * 0.35, size.width * 0.1,
        size.height * 0.36, size.width * 0.1, size.height * 0.36);
    path.cubicTo(size.width * 0.09, size.height * 0.37, size.width * 0.08,
        size.height * 0.38, size.width * 0.07, size.height * 0.38);
    path.cubicTo(size.width * 0.07, size.height * 0.38, size.width * 0.06,
        size.height * 0.38, size.width * 0.05, size.height * 0.38);
    path.cubicTo(size.width * 0.04, size.height * 0.38, size.width * 0.04,
        size.height * 0.38, size.width * 0.03, size.height * 0.38);
    path.cubicTo(size.width * 0.02, size.height * 0.38, size.width * 0.02,
        size.height * 0.37, size.width * 0.01, size.height * 0.36);
    path.cubicTo(size.width * 0.01, size.height * 0.36, size.width * 0.01,
        size.height * 0.35, 0, size.height * 0.32);
    path.cubicTo(
        0, size.height * 0.28, 0, size.height * 0.27, 0, size.height * 0.27);
    path.cubicTo(size.width * 0.01, size.height * 0.26, size.width * 0.02,
        size.height / 4, size.width * 0.03, size.height / 4);
    path.cubicTo(size.width * 0.03, size.height / 4, size.width * 0.04,
        size.height / 4, size.width * 0.05, size.height / 4);
    path.cubicTo(size.width * 0.06, size.height / 4, size.width * 0.06,
        size.height / 4, size.width * 0.06, size.height / 4);
    path.cubicTo(size.width * 0.08, size.height / 4, size.width * 0.09,
        size.height * 0.26, size.width * 0.09, size.height * 0.28);
    path.cubicTo(size.width * 0.09, size.height * 0.28, size.width * 0.09,
        size.height * 0.29, size.width * 0.09, size.height * 0.29);
    path.cubicTo(size.width * 0.09, size.height * 0.29, size.width * 0.1,
        size.height * 0.29, size.width * 0.1, size.height * 0.29);
    path.cubicTo(size.width * 0.1, size.height * 0.29, size.width * 0.11,
        size.height * 0.29, size.width * 0.12, size.height * 0.29);
    path.cubicTo(size.width * 0.12, size.height * 0.29, size.width * 0.13,
        size.height * 0.29, size.width * 0.13, size.height * 0.29);
    path.cubicTo(size.width * 0.13, size.height * 0.29, size.width * 0.13,
        size.height * 0.28, size.width * 0.13, size.height * 0.28);
    path.cubicTo(size.width * 0.13, size.height * 0.28, size.width * 0.13,
        size.height * 0.24, size.width * 0.12, size.height / 5);
    path.cubicTo(size.width * 0.11, size.height * 0.15, size.width * 0.1,
        size.height * 0.11, size.width * 0.11, size.height * 0.11);
    path.cubicTo(size.width * 0.11, size.height * 0.11, size.width * 0.11,
        size.height * 0.11, size.width * 0.12, size.height * 0.11);
    path.cubicTo(size.width * 0.15, size.height * 0.1, size.width * 0.18,
        size.height * 0.1, size.width / 5, size.height * 0.08);
    path.cubicTo(size.width / 5, size.height * 0.08, size.width / 5,
        size.height * 0.08, size.width * 0.22, size.height * 0.07);
    path.cubicTo(size.width * 0.23, size.height * 0.06, size.width / 4,
        size.height * 0.05, size.width * 0.27, size.height * 0.04);
    path.cubicTo(size.width * 0.28, size.height * 0.04, size.width * 0.31,
        size.height * 0.04, size.width / 3, size.height * 0.05);
    path.cubicTo(size.width / 3, size.height * 0.05, size.width / 3,
        size.height * 0.05, size.width / 3, size.height * 0.05);
    path.cubicTo(size.width / 3, size.height * 0.05, size.width * 0.34,
        size.height * 0.04, size.width * 0.34, size.height * 0.04);
    path.cubicTo(size.width * 0.36, size.height * 0.03, size.width * 0.39,
        size.height * 0.02, size.width * 0.41, size.height * 0.01);
    path.cubicTo(size.width * 0.45, 0, size.width / 2, 0, size.width * 0.54, 0);
    path.cubicTo(size.width * 0.58, size.height * 0.01, size.width * 0.61,
        size.height * 0.02, size.width * 0.64, size.height * 0.04);
    path.cubicTo(size.width * 0.65, size.height * 0.04, size.width * 0.65,
        size.height * 0.04, size.width * 0.65, size.height * 0.04);
    path.cubicTo(size.width * 0.66, size.height * 0.04, size.width * 0.66,
        size.height * 0.04, size.width * 0.66, size.height * 0.04);
    path.cubicTo(size.width * 0.68, size.height * 0.04, size.width * 0.69,
        size.height * 0.04, size.width * 0.71, size.height * 0.04);
    path.cubicTo(size.width * 0.73, size.height * 0.04, size.width * 0.76,
        size.height * 0.05, size.width * 0.77, size.height * 0.06);
    path.cubicTo(size.width * 0.81, size.height * 0.08, size.width * 0.85,
        size.height * 0.09, size.width * 0.88, size.height * 0.1);
    path.cubicTo(size.width * 0.88, size.height * 0.1, size.width * 0.89,
        size.height * 0.1, size.width * 0.89, size.height * 0.1);
    path.cubicTo(size.width * 0.89, size.height * 0.1, size.width * 0.89,
        size.height * 0.1, size.width * 0.89, size.height * 0.1);
    path.cubicTo(size.width * 0.89, size.height * 0.13, size.width * 0.86,
        size.height * 0.28, size.width * 0.86, size.height * 0.28);
    path.cubicTo(size.width * 0.86, size.height * 0.28, size.width * 0.89,
        size.height * 0.28, size.width * 0.9, size.height * 0.28);
    path.cubicTo(size.width * 0.9, size.height * 0.28, size.width * 0.91,
        size.height * 0.28, size.width * 0.91, size.height * 0.28);
    path.cubicTo(size.width * 0.91, size.height * 0.28, size.width * 0.91,
        size.height * 0.28, size.width * 0.91, size.height * 0.28);
    path.cubicTo(size.width * 0.91, size.height * 0.26, size.width * 0.92,
        size.height / 4, size.width * 0.93, size.height / 4);
    path.cubicTo(size.width * 0.96, size.height * 0.24, size.width * 0.98,
        size.height / 4, size.width, size.height * 0.26);
    path.cubicTo(size.width, size.height * 0.27, size.width, size.height * 0.28,
        size.width, size.height * 0.32);
    path.cubicTo(size.width, size.height * 0.32, size.width, size.height * 0.32,
        size.width, size.height * 0.32);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, filling);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
