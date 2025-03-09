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
    if (_isProcessing) return;
    _isProcessing = true;

    // 1. Convert 16-bit PCM bytes to floating-point samples
    final samples = _convert16BitPCMToDoubles(bytes);
    final fs = sampleRate.toDouble();
    final filtered = bandPassFilter(samples, fs, 60.0, 1000.0);

    // 2. Check overall energy (RMS)
    final rms = _computeRMS(filtered);
    if (rms < 140) {
      debugPrint('RMS too low: $rms');
      sendPort.send(0.0);
      _isProcessing = false;
      return;
    }

    // 3. Compute spectral flatness to detect noise.
    //    A high spectral flatness (e.g., > 0.5) means the spectrum is almost flat, typical of noise.
    final spectralFlatness = _computeSpectralFlatness(filtered);
    if (spectralFlatness > 0.5) {
      debugPrint(
          'Noise detected (spectral flatness: ${spectralFlatness.toStringAsFixed(2)})');
      sendPort.send(0.0);
      _isProcessing = false;
      return;
    }

    // 4. Detect pitch using the YIN algorithm
    final detectedFrequency = _yinPitchDetection(filtered, sampleRate);
    if (detectedFrequency == null) {
      sendPort.send(0.0);
      _isProcessing = false;
      return;
    }

    debugPrint('RMS: ${rms.toStringAsFixed(2)} Frequency: $detectedFrequency');
    sendPort.send(detectedFrequency);
    _isProcessing = false;
  }

  double _computeRMS(List<double> samples) {
    double sumOfSquares = 0.0;
    for (final sample in samples) {
      sumOfSquares += sample * sample;
    }
    return sqrt(sumOfSquares / samples.length);
  }

  /// Applies a simple bandpass filter by chaining a high-pass and low-pass.
  List<double> bandPassFilter(
    List<double> samples,
    double fs,
    double lowCutHz,
    double highCutHz,
  ) {
    final hpFiltered = highPassFilter(samples, fs, lowCutHz);
    final bpFiltered = lowPassFilter(hpFiltered, fs, highCutHz);
    return bpFiltered;
  }

  /// Single-pole High-Pass Filter
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

  /// Single-pole Low-Pass Filter
  List<double> lowPassFilter(List<double> x, double fs, double cutoffHz) {
    if (cutoffHz >= fs / 2) return x;
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

  /// Converts 16-bit PCM little-endian bytes to List<double>.
  List<double> _convert16BitPCMToDoubles(List<int> bytes) {
    final sampleCount = bytes.length ~/ 2;
    final samples = List<double>.filled(sampleCount, 0, growable: false);
    for (int i = 0; i < sampleCount; i++) {
      final low = bytes[2 * i];
      final high = bytes[2 * i + 1];
      int value = (high << 8) | (low & 0xFF);
      if (value & 0x8000 != 0) {
        value = value - 0x10000;
      }
      samples[i] = value.toDouble();
    }
    return samples;
  }

  /// A basic implementation of the YIN pitch detection algorithm.
  double? _yinPitchDetection(List<double> samples, int sampleRate) {
    final int bufferSize = samples.length;
    if (bufferSize < 2) return null;

    // 1. Squared difference function d[t]
    final d = List<double>.filled(bufferSize, 0);
    for (int t = 1; t < bufferSize; t++) {
      double sum = 0.0;
      for (int i = 0; i < bufferSize - t; i++) {
        final diff = samples[i] - samples[i + t];
        sum += diff * diff;
      }
      d[t] = sum;
    }

    // 2. Cumulative mean normalized difference function (CMND)
    final cmnd = List<double>.filled(bufferSize, 0);
    double runningSum = 0.0;
    for (int t = 1; t < bufferSize; t++) {
      runningSum += d[t];
      cmnd[t] = d[t] * (t / runningSum);
    }

    // 3. Find tau where CMND[t] < threshold
    const double threshold = 0.15;
    int tau = 0;
    for (int t = 2; t < bufferSize; t++) {
      if (cmnd[t] < threshold) {
        int bestT = t;
        while (bestT + 1 < bufferSize && cmnd[bestT + 1] < cmnd[bestT]) {
          bestT++;
        }
        tau = bestT;
        break;
      }
    }
    if (tau == 0) return null;

    // 4. Convert period (tau) to frequency
    return sampleRate / tau;
  }

  /// Computes the spectral flatness of [samples].
  /// A value closer to 1.0 means a flatter (noise-like) spectrum,
  /// while lower values indicate a more tonal (harmonic) spectrum.
  double _computeSpectralFlatness(List<double> samples) {
    final magnitudes = _dft(samples);
    // Skip the DC component (first bin)
    final nonZero = magnitudes.skip(1).toList();
    final arithmeticMean = nonZero.reduce((a, b) => a + b) / nonZero.length;
    double logSum = 0.0;
    for (final m in nonZero) {
      logSum += log(m + 1e-12); // Avoid log(0)
    }
    final geometricMean = exp(logSum / nonZero.length);
    return geometricMean / arithmeticMean;
  }

  /// A simple (but unoptimized) Discrete Fourier Transform.
  List<double> _dft(List<double> samples) {
    final int N = samples.length;
    List<double> magnitudes = List.filled(N, 0.0);
    for (int k = 0; k < N; k++) {
      double real = 0.0;
      double imag = 0.0;
      for (int n = 0; n < N; n++) {
        final angle = 2 * pi * k * n / N;
        real += samples[n] * cos(angle);
        imag -= samples[n] * sin(angle);
      }
      magnitudes[k] = sqrt(real * real + imag * imag);
    }
    return magnitudes;
  }
}
