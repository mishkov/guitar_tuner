import 'package:flutter_fft/flutter_fft.dart';

class FrequencyRecorder {
  Duration _period = Duration();
  Stopwatch _timer = Stopwatch();
  double _frequency = 0.0;
  Function(double frequency) _listener = (_) {};
  FlutterFft _flutterFft = FlutterFft();

  FrequencyRecorder() {
    try {
      _flutterFft = FlutterFft();
      _frequency = _flutterFft.getFrequency;
      _timer.start();
      _asyncInit();
    } catch (e) {
      print(e);
      _frequency = 0.0;
    }
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
