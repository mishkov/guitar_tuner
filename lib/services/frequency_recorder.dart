import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_stream/sound_stream.dart';

class FrequencyRecorder {
  final _soundFrequencyMeter = YinIsolatedDeviationProvider();
  List<StreamSubscription> _subscriptions = [];

  set recordPeriod(Duration period) {}

  set frequencyChangedListener(Function(double frequency) listener) {
    if (_subscriptions.isEmpty) {
      _soundFrequencyMeter.start();
    }

    final subscription = _soundFrequencyMeter.frequencyStream.listen(listener);

    _subscriptions.add(subscription);
  }

  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _soundFrequencyMeter.dispose();
    _soundFrequencyMeter.dispose();
  }
}

const int sampleRate = 48000;

abstract class FrequencyProvider {
  Stream<double> get frequencyStream;
}

class YinIsolatedDeviationProvider implements FrequencyProvider {
  final _deviationProviderController = StreamController<double>.broadcast();
  StreamSubscription<double>? _isolateListener;
  Isolate? _isolate;
  SendPort? _sendPort;

  @override
  Stream<double> get frequencyStream => _deviationProviderController.stream;

  Future<void> start() async {
    final permissionStatus = await Permission.microphone.request();
    if (permissionStatus.isDenied) {
      throw Exception('Microphone permission is not provided');
    }

    final recorder = RecorderStream();

    recorder.audioStream.listen((bytes) {
      final convertedBytes = bytes.toList();
      _sendPort?.send(convertedBytes);
    });

    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn<YinDeviationIsolateArguments>(
      yinDeviationIsolateEntryPoint,
      YinDeviationIsolateArguments(
        token: RootIsolateToken.instance!,
        sendPort: receivePort.sendPort,
      ),
    );

    receivePort.listen((data) {
      if (data is SendPort) {
        _sendPort = data;
      }
      if (data is double) {
        _deviationProviderController.add(data);
      }
    }, onError: (error, stackTrace) {
      _deviationProviderController.addError(error, stackTrace);
    });

    await recorder.initialize(sampleRate: sampleRate);
    await recorder.start();
  }

  Future<void> dispose() async {
    await _isolateListener?.cancel();
    _isolate?.kill();
  }
}

void yinDeviationIsolateEntryPoint(YinDeviationIsolateArguments args) {
  BackgroundIsolateBinaryMessenger.ensureInitialized(args.token);

  final receivePort = ReceivePort();

  args.sendPort.send(receivePort.sendPort);

  YinDeviationIsolate(args.sendPort, receivePort);
}

class YinDeviationIsolateArguments {
  final SendPort sendPort;
  final RootIsolateToken token;

  YinDeviationIsolateArguments({required this.sendPort, required this.token});
}

class YinDeviationIsolate {
  bool _isProcessing = false;
  SendPort sendPort;
  ReceivePort receivePort;

  YinDeviationIsolate(this.sendPort, this.receivePort) {
    receivePort.listen((data) {
      if (data is List<int>) {
        _process(data);
      }
    });
  }

  void _process(List<int> bytes) async {
    if (_isProcessing) {
      return;
    }

    _isProcessing = true;

    // 1. Convert 16-bit PCM bytes to floating-point samples
    final samples = _convert16BitPCMToDoubles(bytes);

    final fs = sampleRate.toDouble();
    final filtered = bandPassFilter(samples, fs, 60.0, 1000.0);

    final rms = _computeRMS(filtered);
    if (rms < 140) {
      debugPrint('RMS: $rms');
      sendPort.send(0.0);

      _isProcessing = false;

      return;
    }

    // 2. Detect pitch using the YIN algorithm
    //    (Adjust buffer size or sample rate as needed for better accuracy.)
    final detectedFrequency = _yinPitchDetection(filtered, sampleRate);

    if (detectedFrequency == null) {
      sendPort.send(0.0);

      _isProcessing = false;

      return;
    }

    debugPrint('RMS: ${rms.toStringAsFixed(2)} $detectedFrequency');

    // 3. Compute how far away this frequency is from the nearest note
    // final deviation = (-(329.6 - detectedFrequency))
    //     .round(); //_computeDeviationInCents(detectedFrequency);

    sendPort.send(detectedFrequency);

    _isProcessing = false;
  }

  double _computeRMS(List<double> samples) {
    double sumOfSquares = 0.0;
    for (final sample in samples) {
      sumOfSquares += sample * sample;
    }
    final meanOfSquares = sumOfSquares / samples.length;
    return sqrt(meanOfSquares); // or math.sqrt(meanOfSquares)
  }

  /// Applies a *very* simple bandpass filter by chaining a high-pass and low-pass.
  /// - `samples`: The time-domain audio samples.
  /// - `fs`: The sample rate (e.g., 16000).
  /// - `lowCutHz`: High-pass cutoff (e.g., 60 Hz).
  /// - `highCutHz`: Low-pass cutoff (e.g., 1000 Hz).
  List<double> bandPassFilter(
    List<double> samples,
    double fs,
    double lowCutHz,
    double highCutHz,
  ) {
    // 1. High-pass filter
    final hpFiltered = highPassFilter(samples, fs, lowCutHz);

    // 2. Low-pass filter
    final bpFiltered = lowPassFilter(hpFiltered, fs, highCutHz);

    return bpFiltered;
  }

  /// Simple single-pole High-Pass Filter
  /// y[n] = alpha * y[n-1] + alpha * (x[n] - x[n-1])
  List<double> highPassFilter(List<double> x, double fs, double cutoffHz) {
    if (cutoffHz <= 0) return x;

    final alpha = exp(-2.0 * pi * cutoffHz / fs);

    List<double> y = List<double>.filled(x.length, 0.0);
    double yPrev = 0.0;
    double xPrev = x.isNotEmpty ? x[0] : 0.0;

    for (int n = 0; n < x.length; n++) {
      final input = x[n];
      final output = alpha * yPrev + alpha * (input - xPrev);
      y[n] = output;

      yPrev = output;
      xPrev = input;
    }

    return y;
  }

  /// Simple single-pole Low-Pass Filter
  /// y[n] = alpha * y[n-1] + (1 - alpha) * x[n]
  List<double> lowPassFilter(List<double> x, double fs, double cutoffHz) {
    if (cutoffHz >= fs / 2) return x; // Can't low-pass above Nyquist

    final alpha = exp(-2.0 * pi * cutoffHz / fs);

    List<double> y = List<double>.filled(x.length, 0.0);
    double yPrev = 0.0;

    for (int n = 0; n < x.length; n++) {
      final input = x[n];
      final output = alpha * yPrev + (1.0 - alpha) * input;
      y[n] = output;
      yPrev = output;
    }

    return y;
  }

  /// Converts a 16-bit PCM little-endian Byte array to List\<double\>.
  /// Assumes that [bytes] has length multiple of 2.
  List<double> _convert16BitPCMToDoubles(List<int> bytes) {
    final sampleCount = bytes.length ~/ 2;
    final samples = List<double>.filled(sampleCount, 0, growable: false);

    for (int i = 0; i < sampleCount; i++) {
      // Little-endian: low byte, high byte
      final low = bytes[2 * i];
      final high = bytes[2 * i + 1];

      // Combine the two bytes into a 16-bit signed value
      int value = (high << 8) | (low & 0xFF);
      if (value & 0x8000 != 0) {
        value = value - 0x10000;
      }

      // Store as double
      samples[i] = value.toDouble();
    }
    return samples;
  }

  /// Performs fundamental frequency estimation using a simplified YIN algorithm.
  /// For best results, you'll likely want at least ~1024 or more samples.
  double? _yinPitchDetection(List<double> samples, int sampleRate) {
    final int bufferSize = samples.length;
    if (bufferSize < 2) return null;

    // 1. Calculate the squared difference function d[t]
    final d = List<double>.filled(bufferSize, 0);
    for (int t = 1; t < bufferSize; t++) {
      double sum = 0.0;
      for (int i = 0; i < bufferSize - t; i++) {
        final diff = samples[i] - samples[i + t];
        sum += diff * diff;
      }
      d[t] = sum;
    }

    // 2. Calculate the cumulative mean normalized difference function CMND[t]
    final cmnd = List<double>.filled(bufferSize, 0);
    double runningSum = 0.0;
    for (int t = 1; t < bufferSize; t++) {
      runningSum += d[t];
      cmnd[t] = d[t] * (t / runningSum);
    }

    // 3. Find the minimum t where CMND[t] < threshold
    const double threshold = 0.15;
    int tau = 0;

    for (int t = 2; t < bufferSize; t++) {
      if (cmnd[t] < threshold) {
        // Optional: refine 't' to the local minimum using the while loop
        int bestT = t;
        while (bestT + 1 < bufferSize && cmnd[bestT + 1] < cmnd[bestT]) {
          bestT++;
        }
        tau = bestT;
        break;
      }
    }

    if (tau == 0) {
      // No good pitch detected
      return null;
    }

    // 4. Convert period (tau) to frequency
    final frequency = sampleRate / tau;
    return frequency;
  }

  /// Given a frequency, return how many cents off it is from the nearest semitone.
  ///
  /// - Return 0.0 if exactly on a standard pitch (like A4 = 440 Hz, E4 = 329.63, etc.).
  /// - Negative if flat, positive if sharp.
  double _computeDeviationInCents(double frequency) {
    if (frequency <= 0.0) return 0.0;

    // Reference note: A4 = 440 Hz
    // Find the closest note (in semitones) to the detected frequency
    // Formula for semitone distance from A4:
    //   semitones = 12 * log2(freq / 440)
    final semitoneDistance = 12 * _log2(frequency / 440.0);

    // Round to nearest integer semitone
    final nearestSemitone = semitoneDistance.round();

    // Frequency of the nearest semitone
    final nearestSemitoneFreq = 440.0 * pow(2.0, nearestSemitone / 12.0);

    // Deviation in cents from that semitone:
    //   100 cents per semitone
    final centOffset = 1200 * _log2(frequency / nearestSemitoneFreq);

    return centOffset;
  }

  /// Helper for log base 2
  double _log2(double x) => log(x) / ln2;
}
