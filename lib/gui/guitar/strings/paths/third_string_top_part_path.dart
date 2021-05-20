import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path thirdStringTopPartPath(Size size) {
  var path = parseSvgPath('''M149 84l-30 196''');

  return scalePath(path, size, Size(219.2, 512.0));
}
