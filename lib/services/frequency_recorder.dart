import 'package:flutter_fft/flutter_fft.dart';

class FrequencyRecorder {
  Duration _period;
  Stopwatch _timer;
  double _frequency;
  Function(double frequency) _listener;
  FlutterFft _flutterFft = FlutterFft();

  FrequencyRecorder() {
    _frequency = _flutterFft.getFrequency;
    _timer = Stopwatch();
    _timer.start();
    _asyncInit();
  }

  double get frequency => _frequency;

  set recordPeriod(Duration period) => _period = period;

  set frequencyChangedListener(Function(double frequency) listener) =>
      _listener = listener;

  _asyncInit() async {
    await _flutterFft.startRecorder();
    _flutterFft.onRecorderStateChanged.listen(_onRecorderStateChangedListener);
  }

  get _onRecorderStateChangedListener => (data) {
        _frequency = data[1];
        _flutterFft.setFrequency = _frequency;

        if (_timer.elapsed > _period) {
          _listener(_frequency);
          _timer.reset();
        }
      };
}
