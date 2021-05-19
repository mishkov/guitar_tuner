import 'dart:ui';

class GuitarNeckPath extends Path {
  GuitarNeckPath(Size size) {
    // Path number 2

    lineTo(size.width * 0.65, size.height * 2.08);
    cubicTo(size.width * 0.65, size.height * 2.08, size.width * 0.64,
        size.height * 2.2, size.width * 0.64, size.height * 2.2);
  }

  @override
  noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}
