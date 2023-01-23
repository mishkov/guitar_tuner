import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

final _path = parseSvgPath('''M72.0785 285.037l-3.0787 251.981''');

Path sixthStringBottomPartPath(Size size) {
  return scalePath(_path, size, const Size(219.2, 512.0));
}
