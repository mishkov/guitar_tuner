import 'dart:math' as math show pi, min, max;

import 'package:flutter/material.dart';

// TODO: данный класс нуждается в рефакторинге, так как он определенно
// нарушает принцип DRY, потому что похожие геттеры находятся в
// абстрактном классе ScaleBackgroundFigure
class Scale {
  var canvas;
  var size;
  var deviationInPercent;

  Scale(Canvas this.canvas, Size this.size, double this.deviationInPercent);

  double get startAngle => math.pi * 1.5;
  double get sweepAngle => (math.pi / 2) * deviationInPercent;

  Path get path => Path()..addArc(bounds, startAngle, sweepAngle);

  Rect get bounds => Rect.fromCircle(
        center: center,
        radius: radius,
      );

  Offset get center => Offset(
        size.width / 2,
        size.width / 2,
      );

  double get radius => height - (backgroundArcWidth / 2);

  double get height => size.width / 2;

  double get backgroundArcWidth {
    const ratio = 0.1769;
    return height * ratio;
  }

  Color get startGradientColor => Color(0xFFFD0054);
  Color get endGradientColor => Color(0xFFA80038);

  SweepGradient get gradient => SweepGradient(
        startAngle: math.min(startAngle, startAngle + sweepAngle),
        endAngle: math.max(startAngle, startAngle + sweepAngle),
        tileMode: TileMode.repeated,
        colors: [
          startGradientColor,
          endGradientColor,
        ],
      );

  double get arcWidth => backgroundArcWidth * 0.4;

  Paint get paint => Paint()
    ..shader = gradient.createShader(bounds)
    ..strokeCap = StrokeCap.butt
    ..style = PaintingStyle.stroke
    ..strokeWidth = arcWidth;

  void draw() {
    canvas.drawPath(path, paint);
  }
}

//     // Draw progress line
//     final progressScaleWidth = scaleBackgroundWidth * 0.4;
//     var progressScaleRadius = scaleBackgroundRadius;

//     const startValueAngle = math.pi;
//     const maxValueAngle = math.pi;
//     const startGradientColor = Color(0xFFFD0054);
//     const endGradientColor = Color(0xFFA80038);
//     final gradient = new SweepGradient(
//       startAngle: startValueAngle,
//       endAngle: startValueAngle + maxValueAngle * _progress,
//       tileMode: TileMode.repeated,
//       colors: [
//         startGradientColor,
//         endGradientColor,
//       ],
//     );
//     var processScaleBouns = Rect.fromCircle(
//       center: scaleCenter,
//       radius: progressScaleRadius,
//     );
//     final progressScalePaint = new Paint()
//       ..shader = gradient.createShader(processScaleBouns)
//       ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = progressScaleWidth;

//     canvas.drawArc(processScaleBouns, startValueAngle,
//         maxValueAngle * _progress, false, progressScalePaint);
