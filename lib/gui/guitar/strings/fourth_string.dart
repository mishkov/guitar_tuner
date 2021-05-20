import 'dart:ui';

import 'guitar_string.dart';
import 'paths/fourth_string_bottom_part_path.dart';
import 'paths/fourth_string_top_part_path.dart';

class FourthString extends GuitarString {
  FourthString(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get bottomPartPath => fourthStringBottomPartPath(size);

  @override
  Path get topPartPath => fourthStringTopPartPath(size);
}
