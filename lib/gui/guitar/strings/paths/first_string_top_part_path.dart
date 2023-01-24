import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

final _path = parseSvgPath('''M142 200L148.49 279.85''');

Path firstStringTopPartPath(Size size) {
  return scalePath(_path, size, const Size(219.2, 512.0));
}
