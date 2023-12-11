import 'package:blove/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors/app_colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final String assetName = 'assets/bLOVEbEARLogoWTypeEdit.svg';
  bool isCreatingAccount = false;
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Function to handle logging in
    handleLogIn() {
      setState(() {
        isLoggingIn = !isLoggingIn;
      });
    }

    // Function to handle creating an account
    handleCreateAccount() {

    }

    handleSubmitLogin() {

    }
    return Scaffold(
      /////// FIX COLOR
      backgroundColor: AppColors.bearSkinTan,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome To',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20,),
            // bLOVE image
            SvgPicture.asset(
              'assets/bLOVEbEARLogoWTypeEdit.svg',
              width: screenWidth * .6, // Size of image based on screen width
              height: screenWidth * .6, // Size of image based on screen width
            ),
            const SizedBox(height: 60,),

            Visibility(
              visible: !isLoggingIn,
              child: Column(
                children: [
                  CustomButton(
                      width: screenWidth * .8,
                      handleButton: handleLogIn,
                      buttonColor: AppColors.bearSkinTan,
                      textColor: Colors.black,
                      height: 40,
                      borderRadius: 15.0,
                      buttonName: 'LOG IN'
                  ),
                  const SizedBox(height: 10,),
                  CustomButton(
                      width: screenWidth * .8,
                      handleButton: handleCreateAccount,
                      buttonColor: Colors.red,
                      textColor: Colors.white,
                      height: 40,
                      borderRadius: 15.0,
                      buttonName: 'CREATE ACCOUNT'
                  ),
                ],
              ),
            ),

            Visibility(
                visible: isLoggingIn,
                child: Column(
                  children: [
                    SizedBox(
                      width: screenWidth * .8,
                      height: 40,
                      child: TextField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: 'Enter text',
                        ),
                      ),
                    ),
                    CustomButton(
                        width: screenWidth * .8,
                        handleButton: handleLogIn,
                        buttonColor: AppColors.bearSkinTan,
                        textColor: Colors.black,
                        height: 40,
                        borderRadius: 15.0,
                        buttonName: 'CANCEL'
                    ),
                    const SizedBox(height: 10,),
                    CustomButton(
                        width: screenWidth * .8,
                        handleButton: handleSubmitLogin,
                        buttonColor: Colors.red,
                        textColor: Colors.white,
                        height: 40,
                        borderRadius: 15.0,
                        buttonName: 'SUBMIT'
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
