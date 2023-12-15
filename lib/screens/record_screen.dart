import 'package:b_love_bear/custom_widgets/custom_tile.dart';
import 'package:b_love_bear/screens/accounts_screen.dart';
import 'package:b_love_bear/screens/bear_screen.dart';
import 'package:b_love_bear/screens/sent_messages_screen.dart';
import 'package:b_love_bear/screens/settings_screen.dart';
import 'package:b_love_bear/screens/show_steps_screen.dart';
import 'package:b_love_bear/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool showContainer = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showContainer) {
          setState(() {
            showContainer = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bLOVEBackground,
        appBar: AppBar(
          backgroundColor: AppColors.bLOVEBackground,
          leading: TextButton(
            onPressed: () {
              setState(() {
                showContainer = !showContainer;
              });
            },
            child: Icon(Icons.menu, color: showContainer ? Colors.grey : Colors.black,),
          ),
        ),
        body: Stack(
          children: [
            if (showContainer)
              Positioned.fill(
                child: Container(
                  color: Colors.transparent,
                  // Add additional logic here if needed
                ),
              ),
            Positioned(
              top: 10.0,
              left: 10.0,
              child: Visibility(
                visible: showContainer,
                child: const MenuNavigation(),
              ),
            ),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Your centered content goes here
                  Text('Centered Text 1'),
                  Text('Centered Text 2'),
                  // Add more centered widgets if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class MenuNavigation extends StatefulWidget {
  const MenuNavigation({Key? key}) : super(key: key);

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 200,
        color: Colors.white.withOpacity(.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(child: const CustomTile(title: 'Sent Messages', bottomBorder: true,), onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SentMessages()),); },),
            InkWell(child: const CustomTile(title: 'Bears', bottomBorder: true,), onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const Bears()),); },),
            InkWell(child: const CustomTile(title: 'Show Steps', bottomBorder: true,), onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ShowSteps()),); },),
            InkWell(child: const CustomTile(title: 'Accounts', bottomBorder: true,), onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const Accounts()),); },),
            InkWell(child: const CustomTile(title: 'Settings', bottomBorder: true,), onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()),); },),
            InkWell(child: const CustomTile(title: 'Log Out', bottomBorder: false, fontColor: AppColors.heartRed,), onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage()),); },),

          ],
        ),
      ),
    );
  }
}

