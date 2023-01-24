import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

final _path = parseSvgPath('''M149 84l-30 196''');

Path thirdStringTopPartPath(Size size) {
  return scalePath(_path, size, const Size(219.2, 512.0));
}
