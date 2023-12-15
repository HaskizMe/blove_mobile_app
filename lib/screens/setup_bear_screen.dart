import 'package:flutter/material.dart';

import '../global_variables/screen_size_values.dart';

class SetupBear extends StatefulWidget {
  const SetupBear({Key? key}) : super(key: key);

  @override
  State<SetupBear> createState() => _SetupBearState();
}

class _SetupBearState extends State<SetupBear> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("setup Bear"),
      ),
      body: Container(
          height: ScreenSize.screenHeight,
          width: ScreenSize.screenWidth,
          color: Colors.blue
      ),
    );;
  }
}
