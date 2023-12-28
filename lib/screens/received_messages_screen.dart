import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../colors/app_colors.dart';
import '../custom_widgets/message_card.dart';
import '../global_variables/screen_size_values.dart';

class ReceivedMessages extends StatefulWidget {
  const ReceivedMessages({super.key});

  @override
  State<ReceivedMessages> createState() => _ReceivedMessagesState();
}

class _ReceivedMessagesState extends State<ReceivedMessages> {
  String currentDate = DateFormat('MM-dd-yyyy, hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
      child: Scaffold(
        backgroundColor: AppColors.bLOVEBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
          child: Column(
            children: [
              ReceivedMessageCard(email: "Haskellb2017@gmail.com", date: currentDate, isListened: true),
              ReceivedMessageCard(email: "asdfasdfasdfasdfasdfasdfafsdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfas", date: currentDate, isListened: false)

            ],
          ),
        ),
      ),
    );
  }
}
