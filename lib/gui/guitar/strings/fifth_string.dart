import 'dart:ui';

import 'guitar_string.dart';
import 'paths/fifth_string_bottom_part_path.dart';
import 'paths/fifth_string_top_part_path.dart';

class FifthString extends GuitarString {
  FifthString(Canvas canvas, Size size) : super(canvas, size);

  @override
  Path get bottomPartPath => fifthStringBottomPartPath(size);

  @override
  Path get topPartPath => fifthStringTopPartPath(size);
}
