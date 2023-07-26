import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guitar_tuner/services/frequency_recorder.dart';
import 'package:guitar_tuner/services/note_tuner.dart';

import 'gui/frequency_deviation_scale/freqeuncy_deviation_scale.dart';
import 'gui/guitar/guitar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppMetrica.activate(
      AppMetricaConfig("40424c4e-8163-4bd1-bee4-69afb9418dba"));
  // I don't know why but scale in release apk doesn't work
  // copied from: https://stackoverflow.com/questions/64552637/how-can-i-solve-flutter-problem-in-release-mode
  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    // In debug mode, use the normal error widget which shows
    // the error message:
    if (inDebug) return ErrorWidget(details.exception);
    // In release builds, show a yellow-on-blue message instead:
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error! ${details.exception}',
        style: TextStyle(color: Colors.yellow),
        textDirection: TextDirection.ltr,
      ),
    );
  };
  AppMetrica.runZoneGuarded(
    () {
      // Here we would normally runApp() the root widget, but to demonstrate
      // the error handling we artificially fail:
      runApp(Application());
    },
  );
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

class TuneRouteState extends State<TuneRoute> {
  double _deviationInHz = 0.0;
  double _deviationInPercent = 0.0;
  String _deviationInText = 'Unknown';
  Note _tunningNote = Note.e1;
  NoteTuner _noteTuner = NoteTuner();
  FrequencyRecorder _frequencyRecorder = FrequencyRecorder();
  Function(Note peg)? _noteChangedListener;

  @override
  void initState() {
    _noteTuner.frequency = 0.0;
    _noteTuner.note = _tunningNote;

    _setupDeviation();

    _frequencyRecorder.recordPeriod = Duration(milliseconds: 300);
    _frequencyRecorder.frequencyChangedListener = (frequency) => setState(() {
          _noteTuner.frequency = frequency;
          _setupDeviation();
        });

    _noteChangedListener = (note) {
      AppMetrica.reportEvent('User selected note: $note');
      AppMetrica.sendEventsBuffer();

      setState(() {
        _noteTuner.note = note;
        _setupDeviation();
      });
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
            Guitar(_noteChangedListener!),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _frequencyRecorder.dispose();
    super.dispose();
  }
}
