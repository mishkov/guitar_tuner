import 'package:flutter/material.dart';

import 'frequency_deviation_scale_painter.dart';

class FrequencyDeviationScale extends StatefulWidget {
  FrequencyDeviationScale(
    this._deviationInHz,
    this._deviationInPercent,
    this._deviationInText,
  );

  final double _deviationInHz;
  final double _deviationInPercent;
  final String _deviationInText;

  @override
  State<StatefulWidget> createState() => _FrequencyDeviationScaleState();
}

class _FrequencyDeviationScaleState extends State<FrequencyDeviationScale> {
  @override
  Widget build(BuildContext context) {
    const margin = 37.0;
    final canvasWidth = MediaQuery.of(context).size.width - 2 * margin;
    final canvasSize = Size(canvasWidth, canvasWidth / 2);

    return CustomPaint(
      size: canvasSize,
      painter: FrequencyDeviationScalePainter(
        widget._deviationInHz,
        widget._deviationInPercent,
        widget._deviationInText,
      ),
    );
  }
}
