import 'package:flutter/material.dart';

Path scalePath(Path pathToScale, Size anchorSize, Size size) {
  var matrix4 = Matrix4.identity();
  matrix4.scale(anchorSize.width / size.width, anchorSize.height / size.height);

  return pathToScale.transform(matrix4.storage);
}
