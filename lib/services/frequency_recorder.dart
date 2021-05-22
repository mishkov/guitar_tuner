import 'dart:async';

import 'package:flutter_fft/flutter_fft.dart';

class FrequencyRecorder {
  Timer _timer;
  Function(double frequency) _listener = (_) {};
  FlutterFft _flutterFft = FlutterFft();

  FrequencyRecorder() {
    try {
      _flutterFft = FlutterFft();
      _asyncInit();
    } catch (e) {
      print(e);
    }

    var period = Duration();
    _timer = Timer.periodic(period, _periodicCode);
  }

  double get frequency => _flutterFft.getFrequency;

  set recordPeriod(Duration period) {
    _timer.cancel();
    _timer = Timer.periodic(period, _periodicCode);
  }

  set frequencyChangedListener(Function(double frequency) listener) =>
      _listener = listener;

  void _asyncInit() async {
    await _flutterFft.startRecorder();
    _flutterFft.onRecorderStateChanged.listen(_onRecorderStateChangedListener);
  }

  void _periodicCode(Timer timer) {
    var newFrequency = _flutterFft.getFrequency;
    _listener(newFrequency);
  }

  get _onRecorderStateChangedListener => (data) {
        _flutterFft.setFrequency = data[1];
      };
}
