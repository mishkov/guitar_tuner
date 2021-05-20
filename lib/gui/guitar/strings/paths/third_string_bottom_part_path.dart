import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path thirdStringBottomPartPath(Size size) {
  var path = parseSvgPath('''M118 284.984l1.319 251.997''');

  return scalePath(path, size, Size(219.2, 512.0));
}
