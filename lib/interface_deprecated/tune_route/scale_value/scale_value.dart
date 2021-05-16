import 'package:flutter/material.dart' show Canvas, Size, TickerProvider, Tween;

import 'scale.dart';
import 'scale_text.dart';

enum Note { e1, b, g, d, A, E }

class ScaleValue {
  static const classicTunedStrings = {
    Note.e1: 329.63,
    Note.b: 246.94,
    Note.g: 196.00,
    Note.d: 146.83,
    Note.A: 110.00,
    Note.E: 82.41,
  };

  var canvas;
  var size;
  var note;
  var frequencyTween;
  var _scale;
  var _text;

  ScaleValue(Canvas this.canvas, Size this.size, Note this.note,
      Tween this.frequencyTween, TickerProvider tickerProvider) {
    _scale = Scale(
        canvas,
        size,
        Tween(
          begin: previousDeviationInPercent,
          end: deviationInPercent,
        ),
        tickerProvider);
    _text = ScaleText(canvas, size, deviationInHz);
  }

  double get maxDeviationInHz => 30.0;

  double get lowerDeviationLimitInPercent => -1.0;

  double get upperDeviationLimitInPercent => 1.0;

  double get previousDeviationInHz =>
      frequencyTween.begin - classicTunedStrings[note];

  double get deviationInHz => frequencyTween.end - classicTunedStrings[note];

  double get previousDeviationInPercent =>
      (previousDeviationInHz / maxDeviationInHz).clamp(
        lowerDeviationLimitInPercent,
        upperDeviationLimitInPercent,
      );

  double get deviationInPercent => (deviationInHz / maxDeviationInHz).clamp(
        lowerDeviationLimitInPercent,
        upperDeviationLimitInPercent,
      );

  void draw() {
    _scale.draw();
    _text.draw();
  }
}
