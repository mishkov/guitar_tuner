import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path firstStringBottomPartPath(Size size) {
  var path = parseSvgPath('''M150 283.947l4.398 251.962''');

  return scalePath(path, size, Size(219.2, 512.0));
}
