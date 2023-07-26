enum Note { e1, b, g, d, A, E }

class NoteTuner {
  Note _note = Note.e1;
  double _frequency = 0.0;

  Map<Note, num> _classicTunedStrings = {
    Note.e1: 329.63,
    Note.b: 246.94,
    Note.g: 196.00,
    Note.d: 146.83,
    Note.A: 110.00,
    Note.E: 82.41,
  };

  set note(Note note) => _note = note;

  set frequency(double frequency) => _frequency = frequency;

  double get deviationInHz {
    if (_frequency != 0.0) {
      return _frequency - _classicTunedStrings[_note]!;
    } else {
      return 0.0;
    }
  }

  double get deviationInPercent {
    if (_frequency != 0.0) {
      return (deviationInHz / _maxDeviationInHz).clamp(
        _lowerDeviationLimitInPercent,
        _upperDeviationLimitInPercent,
      );
    } else {
      return 0.0;
    }
  }

  double get _maxDeviationInHz => 30.0;

  double get _lowerDeviationLimitInPercent => -1.0;

  double get _upperDeviationLimitInPercent => 1.0;

  String get deviationIntext {
    if ((-1.0 <= deviationInPercent) && (deviationInPercent <= -0.50)) {
      return 'Too low';
    } else if ((-0.50 < deviationInPercent) && (deviationInPercent < -0.05)) {
      return 'Low';
    } else if ((-0.05 <= deviationInPercent) && (deviationInPercent < 0.0)) {
      return 'Good';
    } else if (deviationInPercent == 0.0) {
      return 'Silence';
    } else if ((0.0 < deviationInPercent) && (deviationInPercent <= 0.05)) {
      return 'Good';
    } else if ((0.05 < deviationInPercent) && (deviationInPercent < 0.50)) {
      return 'High';
    } else if ((0.50 <= deviationInPercent) && (deviationInPercent <= 1.0)) {
      return 'Too high';
    } else {
      throw Exception('DeviatinoIn Percent is incorect: $deviationInPercent');
    }
  }
}
