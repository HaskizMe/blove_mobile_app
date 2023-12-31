import 'package:b_love_bear/screens/welcome_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'global_variables/screen_size_values.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';


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

  // This widget is the root of the applicatgion.
  @override
  Widget build(BuildContext context) {
    ScreenSize.initialize(context);
    return
    //   ScreenUtilInit(
    //   designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
    //   builder: (context, child) => const MaterialApp(
    //     title: 'bLOVE',
    //     home: WelcomePage(),
    //   ),
    // );
      const MaterialApp(
      title: 'bLOVE',
      home: WelcomePage(),
    );
  }
}