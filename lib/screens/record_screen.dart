import 'package:b_love_bear/custom_widgets/custom_tile.dart';
import 'package:b_love_bear/screens/accounts_screen.dart';
import 'package:b_love_bear/screens/bear_screen.dart';
import 'package:b_love_bear/screens/sent_messages_screen.dart';
import 'package:b_love_bear/screens/settings_screen.dart';
import 'package:b_love_bear/screens/show_steps_screen.dart';
import 'package:b_love_bear/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors/app_colors.dart';
import '../helper_files/navigation_helper.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool showNavigationMenu = false;
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    String bear = "Kris's bear";
    return GestureDetector(
      onTap: () {
        if (showNavigationMenu) {
          setState(() {
            showNavigationMenu = false;
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
                showNavigationMenu = !showNavigationMenu;
              });
            },
            child: Icon(Icons.menu, color: showNavigationMenu ? Colors.grey : Colors.black,),
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Your centered content goes here
                  const Text('STEP ONE:', style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  const Text('PRESS THE RED ICON TO RECORD YOUR'),
                  const Text('bLOVE MESSAGE.'),
                  const SizedBox(height: 40,),
                  Container(
                    width: 150,
                    height: 150,
                    child: IconButton(
                      icon: isRecording ? SvgPicture.asset('assets/StopButtonSmall.svg') : SvgPicture.asset('assets/RecordButtonBig.svg'),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        print("$isRecording");
                        setState(() {
                          isRecording = !isRecording;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('RECORD', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 80,),
                  Text(bear, style: TextStyle(fontSize: 20),),
                  const SizedBox(height: 5,),
                  SvgPicture.asset('assets/bLOVEbEARFrontBig.svg', width: 250, height: 250,),
                  // Add more centered widgets if needed
                ],
              ),
            ),
            if (showNavigationMenu)
              Positioned(
                top: 10.0,
                left: 10.0,
                child: Visibility(
                  visible: showNavigationMenu,
                  child: MenuNavigation(recordPageContext: context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}



class MenuNavigation extends StatefulWidget {
  final BuildContext recordPageContext;
  const MenuNavigation({super.key, required this.recordPageContext});

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  @override
  Widget build(BuildContext context) {
    handleLogOut(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 200,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTile(title: 'Sent Messages', bottomBorder: true, onTapCallback: () => handleNavigation(const SentMessages(), widget.recordPageContext)),
            CustomTile(title: 'Bears', bottomBorder: true, onTapCallback: () => handleNavigation(const Bears(), widget.recordPageContext)),
            CustomTile(title: 'Show Steps', bottomBorder: true, onTapCallback: () => handleNavigation(const ShowSteps(), widget.recordPageContext)),
            CustomTile(title: 'Accounts', bottomBorder: true, onTapCallback: () => handleNavigation(const Accounts(), widget.recordPageContext)),
            CustomTile(title: 'Settings', bottomBorder: true, onTapCallback: () => handleNavigation(const Settings(), widget.recordPageContext)),
            CustomTile(title: 'Log Out', bottomBorder: false, fontColor: AppColors.heartRed, onTapCallback: () => handleLogOut()),
          ],
        ),
      ),
    );
  }
}

