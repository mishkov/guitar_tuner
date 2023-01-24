import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../scale_path.dart';

final _path = parseSvgPath('''M75 149.008l11.1962 133.109''');
Path fifthStringTopPartPath(Size size) {

  return scalePath(_path, size, const Size(219.2, 512.0));
}
