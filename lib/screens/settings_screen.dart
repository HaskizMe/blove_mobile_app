import 'package:flutter/material.dart';

import '../global_variables/screen_size_values.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
          height: ScreenSize.screenHeight,
          width: ScreenSize.screenWidth,
          color: Colors.blue
      ),
    );;
  }
}
