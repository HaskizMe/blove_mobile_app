import 'package:b_love_bear/global_variables/screen_size_values.dart';
import 'package:flutter/material.dart';

class SentMessages extends StatefulWidget {
  const SentMessages({Key? key}) : super(key: key);

  @override
  State<SentMessages> createState() => _SentMessagesState();
}

class _SentMessagesState extends State<SentMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SentMessages"),
      ),
      body: Container(
        height: ScreenSize.screenHeight,
        width: ScreenSize.screenWidth,
        color: Colors.blue
      ),
    );
  }
}
