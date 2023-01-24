import 'dart:async';

import 'package:sound_frequency_meter/sound_frequency_meter.dart';

class FrequencyRecorder {
  SoundFrequencyMeter _soundFrequencyMeter = SoundFrequencyMeter(
    frequenciesBufferSize: 40,
  );
  List<StreamSubscription> _subscriptions = [];

  set recordPeriod(Duration period) {}

  set frequencyChangedListener(Function(double frequency) listener) {
    final subscription = _soundFrequencyMeter.frequencyStream.listen(listener);

    _subscriptions.add(subscription);
  }

  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _soundFrequencyMeter.dispose();
  }
}
