import 'dart:ui';

abstract class NeumorphismFigure {
  NeumorphismFigure(Canvas canvas, Size size);

  void draw();

  void drawWhiteShadow();

  void drawBlackShadow();
}
