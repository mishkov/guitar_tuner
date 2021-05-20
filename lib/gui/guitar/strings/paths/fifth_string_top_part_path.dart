import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path fifthStringTopPartPath(Size size) {
  var path = parseSvgPath('''M75 149.008l11.1962 133.109''');

  return scalePath(path, size, Size(219.2, 512.0));
}
