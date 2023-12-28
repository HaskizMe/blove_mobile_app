import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../colors/app_colors.dart';

class SentMessageCard extends StatelessWidget {
  final bool isListened;
  final String bearName;
  const SentMessageCard({
    super.key,
    required this.isListened,
    required this.bearName
    });

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('MM-dd-yyyy, HH:mm a').format(DateTime.now());

    return Card(
      color: AppColors.bLOVEBackground,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$bearName's Bear", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(currentDate),
                ],
              ),
            ),
            Column(
              children: [
                isListened
                    ? SvgPicture.asset("assets/bLOVEbEARFrontBig.svg", width: 75, height: 75,)
                    : SvgPicture.asset("assets/bLOVEbEARWithGlowingHeartBig.svg", width: 75, height: 75,),
                const SizedBox(height: 2,),
                isListened
                    ? const Text("Listened")
                    : const Text('Received'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ReceivedMessageCard extends StatefulWidget {
  final String email;
  final String date;
  final bool isListened;

  const ReceivedMessageCard({
    super.key,
    required this.email,
    required this.date,
    required this.isListened
  });

  @override
  State<ReceivedMessageCard> createState() => _ReceivedMessageCardState();
}

class _ReceivedMessageCardState extends State<ReceivedMessageCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.bLOVEBackground,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.email, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(widget.date),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  widget.isListened
                      ? SvgPicture.asset("assets/bLOVEbEARFrontBig.svg", width: 75, height: 75,)
                      : SvgPicture.asset("assets/bLOVEbEARWithGlowingHeartBig.svg", width: 75, height: 75,),
                  const SizedBox(height: 2,),
                  widget.isListened
                      ? const Text("Listened")
                      : const Text('Received'),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_circle_outlined,
                        color: AppColors.heartRed,
                        size: 40,
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

