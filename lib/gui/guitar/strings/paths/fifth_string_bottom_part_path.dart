import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path fifthStringBottomPartPath(Size size) {
  var path = parseSvgPath('''M86 281.999v252''');

  return scalePath(path, size, Size(219.2, 512.0));
}
