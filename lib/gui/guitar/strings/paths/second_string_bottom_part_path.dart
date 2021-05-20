import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path secondStringBottomPartPath(Size size) {
  var path = parseSvgPath('''M134 283.974l2.199 251.99''');

  return scalePath(path, size, Size(219.2, 512.0));
}
