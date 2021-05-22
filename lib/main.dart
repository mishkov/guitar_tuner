import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
  double _deviationInHz = 0.0;
  double _deviationInPercent = 0.0;
  String _deviationInText = 'Unknown';
  Note _tunningNote = Note.e1;
  NoteTuner _noteTuner = NoteTuner();
  FrequencyRecorder _frequencyRecorder = FrequencyRecorder();
  Function(Note peg) _noteChangedListener;

  @override
  void initState() {
    _noteTuner.frequency = 0.0;
    _noteTuner.note = _tunningNote;

    _setupDeviation();

    _frequencyRecorder.recordPeriod = Duration(milliseconds: 500);
    _frequencyRecorder.frequencyChangedListener = (frequency) {
      setState(() {
        _noteTuner.frequency = frequency;
        _setupDeviation();
      });
    };

    _noteChangedListener = (note) {
      print('CHANGED');
      _noteTuner.note = note;
    };
    super.initState();
  }

  void _setupDeviation() {
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
        color: const Color(0xFFDDDDDDD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                left: scaleMargin,
                top: scaleMargin + statusBarHeight,
                right: scaleMargin,
              ),
              child: FrequencyDeviationScale(
                _deviationInHz,
                _deviationInPercent,
                _deviationInText,
              ),
            ),
            Guitar(_noteChangedListener),
          ],
        ),
      ),
    );
  }
}
