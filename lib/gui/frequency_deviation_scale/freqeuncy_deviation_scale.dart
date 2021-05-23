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

class _FrequencyDeviationScaleState extends State<FrequencyDeviationScale>
    with TickerProviderStateMixin {
  Animation<double> _deviationInHzAnimation;
  AnimationController _deviationInHzController;
  double _lastDeviationInHz = 0.0;

  Animation<double> _deviationInPercentAnimation;
  AnimationController _deviationInPercentController;
  double _lastDeviationInPercent = 0.0;

  @override
  void initState() {
    super.initState();
    var animationDuration = Duration(milliseconds: 300);
    _deviationInPercentController = AnimationController(
      duration: animationDuration,
      vsync: this,
    );
    _initDeviationInPercentAnimation();

    _deviationInHzController = AnimationController(
      duration: animationDuration,
      vsync: this,
    );
    _deviationInHzController = AnimationController(
      duration: animationDuration,
      vsync: this,
    );
    _initDeviationInHzAnimation();
  }

  @override
  void didUpdateWidget(_) {
    super.didUpdateWidget(_);
    _initDeviationInPercentAnimation();
    _initDeviationInHzAnimation();
  }

  void _initDeviationInPercentAnimation() {
    var deviationInPercentTween = Tween<double>(
      begin: _lastDeviationInPercent,
      end: widget._deviationInPercent,
    );
    _lastDeviationInPercent = widget._deviationInPercent;
    _deviationInPercentAnimation =
        deviationInPercentTween.animate(_deviationInPercentController)
          ..addListener(() {
            setState(() {});
          });

    if (_deviationInPercentController.status == AnimationStatus.completed) {
      _deviationInPercentController.reset();
    }
    _deviationInPercentController.forward();
  }

  void _initDeviationInHzAnimation() {
    var deviationInHzTween = Tween<double>(
      begin: _lastDeviationInHz,
      end: widget._deviationInHz,
    );
    _lastDeviationInHz = widget._deviationInHz;
    _deviationInHzAnimation =
        deviationInHzTween.animate(_deviationInHzController)
          ..addListener(() {
            setState(() {});
          });

    if (_deviationInHzController.status == AnimationStatus.completed) {
      _deviationInHzController.reset();
    }
    _deviationInHzController.forward();
  }

  @override
  Widget build(BuildContext context) {
    const margin = 37.0;
    final canvasWidth = MediaQuery.of(context).size.width - 2 * margin;
    final canvasSize = Size(canvasWidth, canvasWidth / 2);

    return CustomPaint(
      size: canvasSize,
      painter: FrequencyDeviationScalePainter(
        _deviationInHzAnimation.value,
        _deviationInPercentAnimation.value,
        widget._deviationInText,
      ),
    );
  }

  @override
  void dispose() {
    //_deviationInHzController.dispose();
    _deviationInPercentController.dispose();
    super.dispose();
  }
}
