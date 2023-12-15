import 'package:flutter/material.dart';

import '../global_variables/screen_size_values.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: Container(
          height: ScreenSize.screenHeight,
          width: ScreenSize.screenWidth,
          color: Colors.blue
      ),
    );;
  }
}
