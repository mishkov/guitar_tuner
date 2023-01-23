import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

final _path = parseSvgPath('''M101.44 285.005l-.44 252''');

Path fourthStringBottomPartPath(Size size) {
  return scalePath(_path, size, const Size(219.2, 512.0));
}
