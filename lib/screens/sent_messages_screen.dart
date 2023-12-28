import 'package:b_love_bear/custom_widgets/message_card.dart';
import 'package:b_love_bear/global_variables/screen_size_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../colors/app_colors.dart';

class SentMessages extends StatefulWidget {
  const SentMessages({super.key});

  @override
  State<SentMessages> createState() => _SentMessagesState();
}

class _SentMessagesState extends State<SentMessages> {
  bool isReceived = true;
  bool isListened = false;
  // String currentDate = DateFormat('MM-dd-yyyy, HH:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return const ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      child: Scaffold(
        backgroundColor: AppColors.bLOVEBackground,
        body: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
          child: Column(
            children: [
              SentMessageCard(isListened: true, bearName: "Colton",),
              SentMessageCard(isListened: false, bearName: "Bailey",),
            ],
          ),
        ),
      ),
    );
  }
}
