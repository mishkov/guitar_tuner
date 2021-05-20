import 'dart:ui';

import 'guitar_string.dart';
import 'paths/third_string_bottom_part_path.dart';
import 'paths/third_string_top_part_path.dart';

class ThirdString extends GuitarString {
  ThirdString(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get bottomPartPath => thirdStringBottomPartPath(size);

  @override
  Path get topPartPath => thirdStringTopPartPath(size);
}
