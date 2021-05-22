import 'dart:async';

import 'package:flutter_fft/flutter_fft.dart';

class FrequencyRecorder {
  Timer _timer;
  double _lastFrequency = 0.0;
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

  double get frequency {
    if (_lastFrequency != _flutterFft.getFrequency) {
      _lastFrequency = _flutterFft.getFrequency;
      return _flutterFft.getFrequency;
    } else {
      _flutterFft.setFrequency = 0.0;
      _lastFrequency = 0.0;
      return 0.0;
    }
  }

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
    _listener(frequency);
  }

  get _onRecorderStateChangedListener => (data) {
        _flutterFft.setFrequency = data[1];
      };
}
