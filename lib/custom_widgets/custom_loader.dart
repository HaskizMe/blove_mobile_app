import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final String text;
  const CustomLoader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        color: AppColors.heartRed.withOpacity(.6),
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(color: Colors.white, radius: 20.0,),
            const SizedBox(height: 15,),
            Text(text, style: const TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
