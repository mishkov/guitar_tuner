import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path fourthStringTopPartPath(Size size) {
  var path = parseSvgPath('''M70 85.0085L101 279''');

  return scalePath(path, size, Size(219.2, 512.0));
}
