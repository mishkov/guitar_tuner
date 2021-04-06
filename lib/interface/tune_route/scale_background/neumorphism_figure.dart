import 'dart:ui';

abstract class NeumorphismFigure {
  NeumorphismFigure(Canvas canvas, Size size);

  void drawBody();

  void drawWhiteShadow();

  void drawBlackShadow();
}
