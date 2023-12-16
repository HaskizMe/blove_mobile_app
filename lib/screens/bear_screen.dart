import 'package:flutter/material.dart';

import '../global_variables/screen_size_values.dart';

class Bears extends StatefulWidget {
  const Bears({Key? key}) : super(key: key);

  @override
  State<Bears> createState() => _BearsState();
}

class _BearsState extends State<Bears> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bears"),
      ),
      body: Container(
          height: ScreenSize.screenHeight,
          width: ScreenSize.screenWidth,
          color: Colors.blue
      ),
    );;
  }
}
