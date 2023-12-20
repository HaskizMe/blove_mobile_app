import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors/app_colors.dart';

class BearCard extends StatelessWidget {
  bool isSelected;
  final String name;
  BearCard({super.key, required this.isSelected, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.bLOVEBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: isSelected ? AppColors.heartRed : Colors.black, width: 1),
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
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Column(
              children: [
                SvgPicture.asset(isSelected ? 'assets/bLOVEbEARWithGlowingHeartBig.svg' : 'assets/bLOVEbEARFrontBig.svg', width: 75, height: 75,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
