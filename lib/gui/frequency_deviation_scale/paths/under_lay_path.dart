import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

var path = parseSvgPath(
    '''M332 170C336.418 170 340.02 166.416 339.812 162.002C337.827 119.826
    320.199 79.7829 290.208 49.7919C258.327 17.9107 215.087 3.40396e-06 170
    0C124.913 -3.40396e-06 81.673 17.9107 49.7919 49.7918C19.8008 79.7829
    2.17284 119.826 0.188044 162.002C-0.0196486 166.416 3.58172 170 8
    170L22.0703 170C26.4885 170 30.0464 166.414 30.2987 162.003C32.2548 127.807
    46.7039 95.4055 71.0547 71.0547C97.2967 44.8128 132.888 30.0702 170
    30.0703C207.112 30.0703 242.703 44.8128 268.945 71.0547C293.296 95.4056
    307.745 127.807 309.701 162.003C309.954 166.414 313.511 170 317.93
    170H332Z''');

Path underLayPath(Size size) {
  return _scalePath(path, size);
}

Path _scalePath(Path path, Size size) {
  var pathBounds = path.getBounds();
  var matrix4 = Matrix4.identity();
  matrix4.scale(size.width / pathBounds.width, size.height / pathBounds.height);

  return path.transform(matrix4.storage);
}
