import 'dart:ui';

import 'guitar_string.dart';
import 'paths/second_string_bottom_part_path.dart';
import 'paths/second_string_top_part_path.dart';

class SecondString extends GuitarString {
  SecondString(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get bottomPartPath => secondStringBottomPartPath(size);

  @override
  Path get topPartPath => secondStringTopPartPath(size);
}
