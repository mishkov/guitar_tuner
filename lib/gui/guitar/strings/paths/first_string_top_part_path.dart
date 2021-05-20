import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path firstStringTopPartPath(Size size) {
  var path = parseSvgPath('''M142 200L148.49 279.85''');

  return scalePath(path, size, Size(219.2, 512.0));
}
