import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path fourthStringBottomPartPath(Size size) {
  var path = parseSvgPath('''M101.44 285.005l-.44 252''');

  return scalePath(path, size, Size(219.2, 512.0));
}
