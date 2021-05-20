import 'dart:ui';

import 'guitar_string.dart';
import 'paths/first_string_bottom_part_path.dart';
import 'paths/first_string_top_part_path.dart';

class FirstString extends GuitarString {
  FirstString(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get bottomPartPath => firstStringBottomPartPath(size);

  @override
  Path get topPartPath => firstStringTopPartPath(size);
}
