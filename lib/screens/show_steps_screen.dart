import 'package:flutter/material.dart';

import '../global_variables/screen_size_values.dart';

class ShowSteps extends StatefulWidget {
  const ShowSteps({Key? key}) : super(key: key);

  @override
  State<ShowSteps> createState() => _ShowStepsState();
}

class _ShowStepsState extends State<ShowSteps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("show steps"),
      ),
      body: Container(
          height: ScreenSize.screenHeight,
          width: ScreenSize.screenWidth,
          color: Colors.blue
      ),
    );;
  }
}
