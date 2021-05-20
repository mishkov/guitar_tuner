import 'dart:ui';

import 'guitar_string.dart';
import 'paths/sixth_string_bottom_part_path.dart';
import 'paths/sixth_string_top_part_path.dart';

class SixthString extends GuitarString {
  SixthString(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get bottomPartPath => sixthStringBottomPartPath(size);

  @override
  Path get topPartPath => sixthStringTopPartPath(size);
}
