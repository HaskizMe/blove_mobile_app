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
      blastDirectionality: BlastDirectionality.explosive,
      // minimumSize: const Size(10, 10), // set the minimum potential size for the confetti (width, height)
      // maximumSize: const Size(30, 30),
      // particleDrag: 0.05,
      // // maxBlastForce: 10, // set a lower max blast force
      // // minBlastForce: 5, // set a lower min blast force
      // emissionFrequency: 0.05,
      numberOfParticles: 20, // a lot of particles at once
      // gravity: .05,
      shouldLoop: false,
      // createParticlePath: (size) => staticHeartPath(),
      // createParticlePath: drawHeart,
      colors: const [
        AppColors.heartRed,
        AppColors.heartPink,
        AppColors.heartLightPink
      ],
    );
  }
}



