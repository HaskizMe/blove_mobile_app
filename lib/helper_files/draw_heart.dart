import 'package:flutter/material.dart';

Path drawHeart(Size size) {

  double width = 50;
  double height = 50;

  Path path = Path();
  path.moveTo(0.5 * width, height * 0.35);
  path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6, 0.5 * width, height);
  path.moveTo(0.5 * width, height * 0.35);
  path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6, 0.5 * width, height);

  // Close the path
  path.close();

  return path;
}