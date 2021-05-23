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

// TODO: Refactor this class
class _FrequencyDeviationScaleState extends State<FrequencyDeviationScale>
    with TickerProviderStateMixin {
  Animation<double> _deviationInHzAnimation;
  AnimationController _deviationInHzController;

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
    // var animationDuration = const Duration(milliseconds: 2000);
    // _deviationInHzController = AnimationController(
    //   duration: animationDuration,
    //   vsync: this,
    // );

    // var _deviationInHzTween = Tween<double>(
    //   begin: 0,
    //   end: widget._deviationInHz,
    // );
    // _deviationInHzAnimation =
    //     _deviationInHzTween.animate(_deviationInHzController)
    //       ..addListener(() {
    //         setState(() {
    //           // The state that has changed here is the animation object’s value.
    //         });
    //       });
    // _deviationInHzController.forward();
    // _deviationInPercentAnimation =
    //     _deviationInPercentTween.animate(_deviationInPercentController)
    //       ..addStatusListener((status) {
    //         print('this is addStatusListener');
    //       })
    //       ..addListener(() {
    //         print('this is addListener');
    //         setState(() {
    //           // The state that has changed here is the animation object’s value.
    //         });
    //       });
  }

  @override
  void didUpdateWidget(_) {
    super.didUpdateWidget(_);
    _initDeviationInPercentAnimation();
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

  @override
  Widget build(BuildContext context) {
    const margin = 37.0;
    final canvasWidth = MediaQuery.of(context).size.width - 2 * margin;
    final canvasSize = Size(canvasWidth, canvasWidth / 2);

    return CustomPaint(
      size: canvasSize,
      painter: FrequencyDeviationScalePainter(
        widget._deviationInHz, //_deviationInHzAnimation.value,
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
