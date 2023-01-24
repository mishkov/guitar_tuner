import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

final _path = parseSvgPath('''M145.582 145.118L134 280''');

Path secondStringTopPartPath(Size size) {
  return scalePath(_path, size, const Size(219.2, 512.0));
}
