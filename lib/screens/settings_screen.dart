import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:confetti/confetti.dart';
import '../colors/app_colors.dart';
import '../controllers/bluetooth_controller.dart';
import '../global_variables/screen_size_values.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 5));
  }
  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

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



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              //TOP CENTER - shoot down
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _controllerTopCenter,
                  blastDirection: pi / 2,
                  maxBlastForce: 5, // set a lower max blast force
                  minBlastForce: 2, // set a lower min blast force
                  emissionFrequency: 0.05,
                  numberOfParticles: 10, // a lot of particles at once
                  gravity: .05,
                  createParticlePath: drawHeart,
                  colors: const [
                    AppColors.heartRed,
                    AppColors.heartPink,
                    AppColors.heartLightPink
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: TextButton(
                    onPressed: () {
                      _controllerTopCenter.play();
                    },
                    child: const Text('goliath')),
              ),
              //BOTTOM CENTER

              // Align(
              //   alignment: Alignment.center,
              //   child: CustomPaint(
              //     size: const Size(70, 80),
              //     painter: HeartPainter(),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();
    paint
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    Paint paint1 = Paint();
    paint1
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
        0.5 * width, height);
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
        0.5 * width, height);

    canvas.drawPath(path, paint1);
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
