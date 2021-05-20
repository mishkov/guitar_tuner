import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path secondStringTopPartPath(Size size) {
  var path = parseSvgPath('''M145.582 145.118L134 280''');

  return scalePath(path, size, Size(219.2, 512.0));
}
