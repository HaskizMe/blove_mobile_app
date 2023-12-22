import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../screens/welcome_screen.dart';

class CustomActionSheet extends StatelessWidget {
  const CustomActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
          title: Text('Log out?'),
          message: Text("Are you sure you wish to log out?"),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                // Perform logout logic here
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                      (route) => false,
                );
              },
              child: const Text('Yes', style: TextStyle(color: AppColors.heartRed),),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context); // Close the bottom sheet
            },
            child: const Text('No', style: TextStyle(color: Colors.blue),),
          ),
        );
  }
}
