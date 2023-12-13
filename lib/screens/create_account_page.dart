import 'dart:async';

import 'package:b_love_bear/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors/app_colors.dart';
import '../custom_widgets/custom_button.dart';
import '../global_variables/screen_size_values.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final String bearWithoutGlowingHeart = 'assets/bLOVEbEARFrontBig.svg';
  final String bearWithGlowingHeart = 'assets/bLOVEbEARWithGlowingHeartBig.svg';
  String currentBearImage = 'assets/bLOVEbEARFrontBig.svg';
  late Timer timer;
  bool showAccountCreationLayout = false; // Add this variable

  @override
  void initState() {
    super.initState();
    print('Modal sheet opened...');

    // Start a timer to change the bear image every .5 seconds
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        currentBearImage = (currentBearImage == bearWithoutGlowingHeart)
            ? bearWithGlowingHeart
            : bearWithoutGlowingHeart;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        child: SizedBox(
          height: ScreenSize.screenHeight,
          width: ScreenSize.screenWidth,
          child: GestureDetector(
            onTap: () {
              // Toggle the state to show a different layout
              setState(() {
                showAccountCreationLayout = true;
              });
            },
            child: Material(
              color: AppColors.bLOVEBackground,
              child: showAccountCreationLayout
                  ? AccountCreation(onBackArrowTapped: () {
                    setState(() {
                      showAccountCreationLayout = false;
                    });
                    },
              ) // Show a different layout
                  : BlinkingBear(currentBear: currentBearImage),
            ),
          ),
        ),
      ),
    );
  }
}



class BlinkingBear extends StatefulWidget {
  final String currentBear;
  const BlinkingBear({super.key, required this.currentBear});

  @override
  State<BlinkingBear> createState() => _BlinkingBearState();
}

class _BlinkingBearState extends State<BlinkingBear> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "When You Can't",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        const Text(
          "Be There, bLOVE.",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 20,),
        SvgPicture.asset(
          widget.currentBear,
          width: ScreenSize.screenWidth * .6, // Size of image based on screen width
          height: ScreenSize.screenWidth * .6, // Size of image based on screen width
        ),
        const SizedBox(height: 20,),
        const Text(
          "THE TEDDY BEAR",
          style: TextStyle(
              fontSize: 30
          ),
        ),
        const Text(
          "THAT'S WHERE",
          style: TextStyle(
              fontSize: 30
          ),
        ),
        const Text(
          "YOU WANT TO BE",
          style: TextStyle(
              fontSize: 30
          ),
        ),
      ],
    );
  }
}



class AccountCreation extends StatefulWidget {
  final VoidCallback onBackArrowTapped;

  const AccountCreation({super.key, required this.onBackArrowTapped});

  @override
  State<AccountCreation> createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bLOVEBackground,
      appBar: AppBar(
        leadingWidth: 120,
        leading: ElevatedButton(
          onPressed: widget.onBackArrowTapped,
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_new, color: Colors.red),
              SizedBox(width: 2.0),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),

        ),
        // GestureDetector(
        //   onTap: widget.onBackArrowTapped,
        //   child: const Padding(
        //     padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
        //     child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Icon(Icons.arrow_back_ios_new, color: Colors.red,),
        //           Text(
        //             'Back', style: TextStyle(
        //             fontSize: 18,
        //             color: Colors.red
        //           ),
        //           ),
        //     ]
        //     ),
        //   ), // You can use any widget here
        // ),
        backgroundColor: AppColors.bLOVEBackground,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/bLOVEbEARFrontBig.svg"),
        ],
      ),
    );
  }
}