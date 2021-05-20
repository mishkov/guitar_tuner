import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

Path sixthStringBottomPartPath(Size size) {
  var path = parseSvgPath('''M72.0785 285.037l-3.0787 251.981''');

  return scalePath(path, size, Size(219.2, 512.0));
}
