import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

final _path = parseSvgPath('''M134 283.974l2.199 251.99''');

Path secondStringBottomPartPath(Size size) {
  return scalePath(_path, size, const Size(219.2, 512.0));
}
