import 'dart:math';

import 'package:flutter/material.dart';

Path drawHeart(Size size) {

  const double width = 30;
  const double height = 30;

  Path path = Path();
  path.moveTo(0.5 * size.width, size.height * 0.35);
  path.cubicTo(0.2 * size.width, size.height * 0.1, -0.25 * size.width, size.height * 0.6, 0.5 * size.width, size.height);
  path.moveTo(0.5 * size.width, size.height * 0.35);
  path.cubicTo(0.8 * size.width, size.height * 0.1, 1.25 * size.width, size.height * 0.6, 0.5 * size.width, size.height);
  // path.moveTo(0.5 * width, height * 0.35);
  //
  // // Left side of the heart
  // path.lineTo(0.5 * width, 0.0);
  // path.lineTo(0.0, 0.2 * height);
  //
  // // Right side of the heart
  // path.moveTo(0.5 * width, height * 0.35);
  // path.lineTo(width, 0.2 * height);
  // path.lineTo(0.5 * width, 0.0);
  // Close the path
  path.close();

  return path;
}
Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep), halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}

Path staticHeartPath() {
  double width = 30;
  double height = 30;

  Path path = Path();
  path.moveTo(0.5 * width, height * 0.35);
  path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6, 0.5 * width, height);
  path.moveTo(0.5 * width, height * 0.35);
  path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6, 0.5 * width, height);

  // Close the path
  path.close();

  return path;
}

Path drawHeart2(Size size) {
  double width = 30;
  double height = 30;

  Path path = Path();
  path.moveTo(0.5 * width, height);

  path.cubicTo(
    0.7 * width, height * 0.7,
    width, height * 0.3,
    0.5 * width, 0,
  );

  path.cubicTo(
    0, height * 0.3,
    0.3 * width, height * 0.7,
    0.5 * width, height,
  );

  // Close the path
  path.close();

  return path;
}

Path drawHeart3(Size size) {
  double width = size.width;
  double height = size.height;

  Path path = Path();

  path.moveTo(0.5 * width, 0.9 * height);
  path.quadraticBezierTo(0.2 * width, 0.6 * height, 0.5 * width, 0.2 * height);
  path.quadraticBezierTo(0.8 * width, 0.6 * height, 0.5 * width, 0.9 * height);

  // Close the path
  path.close();

  return path;
}


class HeartPainter extends StatelessWidget {
  final Path heartPath;

  HeartPainter({required this.heartPath});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HeartShapePainter(heartPath),
    );
  }
}

class _HeartShapePainter extends CustomPainter {
  final Path heartPath;

  _HeartShapePainter(this.heartPath);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawPath(heartPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Assuming the path is static and doesn't change
  }
}

