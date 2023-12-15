import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
void showErrorDialog(BuildContext context, String errorString, String solutionString) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(errorString),
        content: Text(solutionString),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('DISMISS', style: TextStyle(color: AppColors.heartRed),))
        ],
      );
      //   AlertDialog(
      //   title: Text(errorString),
      //   content: Text(solutionString),
      //   actions: [
      //     TextButton(
      //       onPressed: () {
      //         Navigator.pop(context); // Dismiss the dialog
      //       },
      //       child: Text('DISMISS', style: TextStyle(color: AppColors.heartRed),),
      //     ),
      //   ],
      // );
    },
  );
}