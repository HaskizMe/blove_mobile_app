import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../colors/app_colors.dart';

class SentMessageCard extends StatelessWidget {
  const SentMessageCard({super.key});

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
                  Text("Colton's Bear", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(currentDate),
                ],
              ),
            ),
            Column(
              children: [
                SvgPicture.asset('assets/bLOVEbEARFrontBig.svg', width: 75, height: 75,),
                const SizedBox(height: 2,),
                Text('Recieved'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
