import 'package:blove/screens/welcome_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'colors/app_colors.dart';




/*
THINGS TO FIX
--------------------------
- fix colors
- fix font type
 */



void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'bLOVE',
      home: WelcomePage(),
    );
  }
}