import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors/app_colors.dart';
import '../custom_widgets/custom_button.dart';
import '../global_variables/screen_size_values.dart';

// class WelcomeView extends StatefulWidget {
//   final Function updateLogin;
//   final Function updateCreateAccount;
//   const WelcomeView({super.key, required this.updateLogin, required this.updateCreateAccount});
//
//   @override
//   State<WelcomeView> createState() => _WelcomeViewState();
// }
//
// class _WelcomeViewState extends State<WelcomeView> {
//   double height = 40;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Your non-login widgets
//         CustomButton(
//           width: ScreenSize.screenWidth * .8,
//           handleButton: widget.updateLogin,
//           buttonColor: AppColors.bearSkinTan,
//           textColor: Colors.black,
//           height: height,
//           borderRadius: 15.0,
//           buttonName: 'LOG IN',
//         ),
//         const SizedBox(height: 10,),
//         CustomButton(
//           width: ScreenSize.screenWidth * .8,
//           handleButton: widget.updateCreateAccount,
//           buttonColor: Colors.red,
//           textColor: Colors.white,
//           height: height,
//           borderRadius: 15.0,
//           buttonName: 'CREATE ACCOUNT',
//         ),
//       ],
//     );
//   }
// }

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
    //double screenHeight = MediaQuery.of(context).size.height;

    //print('value: ${await _modalClosedCompleter.future}');
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        child: SizedBox(
          height: ScreenSize.screenHeight,
          width: ScreenSize.screenWidth,
          child: Material(
            color: AppColors.bearSkinTan,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                const Text("When You Can't\nBe There, bLOVE."),
                const SizedBox(height: 20,),
                SvgPicture.asset(
                  currentBearImage,
                  width: ScreenSize.screenWidth * .6, // Size of image based on screen width
                  height: ScreenSize.screenWidth * .6, // Size of image based on screen width
                ),
                const SizedBox(height: 20,),
                const Text("THE TEDDY BEAR\nTHATS'S WHERE\nYOU WANT TO BE"),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
