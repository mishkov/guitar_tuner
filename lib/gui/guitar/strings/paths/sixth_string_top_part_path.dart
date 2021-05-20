import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path sixthStringTopPartPath(Size size) {
  var path = parseSvgPath('''M77.2006 200.15L72 279''');

  return scalePath(path, size, Size(219.2, 512.0));
}
