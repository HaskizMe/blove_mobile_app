import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../helper_files/draw_heart.dart';

class CustomConfetti extends StatelessWidget {
  final ConfettiController controller;
  const CustomConfetti({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: controller,
      blastDirection: pi / 2,
      maxBlastForce: 5, // set a lower max blast force
      minBlastForce: 2, // set a lower min blast force
      emissionFrequency: 0.05,
      numberOfParticles: 2, // a lot of particles at once
      gravity: .05,
      createParticlePath: drawHeart,
      colors: const [
        AppColors.heartRed,
        AppColors.heartPink,
        AppColors.heartLightPink
      ],
    );
  }
}
