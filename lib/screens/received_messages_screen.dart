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
              Container(
                width: ScreenSize.screenWidth * .3,
                height: 8,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.6),
                    borderRadius: BorderRadius.circular(20.0)
                ),
              ),
              const SizedBox(height: 25,),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return ReceivedMessageCard(
                      email: "Haskellb2017@gmail.com", // Replace this with dynamic data if needed
                      date: currentDate, // Replace this with dynamic data if needed
                      isListened: index == 0, // Mark the first item as listened
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
