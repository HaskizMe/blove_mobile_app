import 'package:blove/custom_widgets/custom_button.dart';
import 'package:blove/custom_widgets/custom_text_field.dart';
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
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double height = 40;

    // Function to handle logging in
    handleLogIn() {
      setState(() {
        isLoggingIn = !isLoggingIn;
      });
    }

    // Function to handle creating an account
    handleCreateAccount() {
      // Shows screen pop up to make account
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
                initialChildSize: 0.95,
                maxChildSize: 0.95,
                minChildSize: 0.95,
                expand: true,
                builder: (context, scrollController) {
                  return const MyModalSheet();
                }
            );
          }
      );
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
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: isLoggingIn
                  ? Column(
                key: ValueKey<bool>(isLoggingIn),
                children: [
                  // Your login widgets
                  CustomTextField(
                    width: screenWidth * .8,
                    textController: emailTextController,
                    height: height,
                    hintText: "EMAIL ADDRESS",
                    isObscure: false,
                  ),
                  const SizedBox(height: 10,),
                  CustomTextField(
                    width: screenWidth * .8,
                    textController: passwordTextController,
                    height: height,
                    hintText: "PASSWORD",
                    isObscure: true,
                  ),
                  const SizedBox(height: 10,),
                  CustomButton(
                    width: screenWidth * .8,
                    handleButton: handleLogIn,
                    buttonColor: AppColors.bearSkinTan,
                    textColor: Colors.black,
                    height: 40,
                    borderRadius: 15.0,
                    buttonName: 'CANCEL',
                  ),
                  const SizedBox(height: 10,),
                  CustomButton(
                    width: screenWidth * .8,
                    handleButton: handleSubmitLogin,
                    buttonColor: Colors.red,
                    textColor: Colors.white,
                    height: 40,
                    borderRadius: 15.0,
                    buttonName: 'SUBMIT',
                  ),
                ],
              )
                  : Column(
                key: ValueKey<bool>(isLoggingIn),
                children: [
                  // Your non-login widgets
                  CustomButton(
                    width: screenWidth * .8,
                    handleButton: handleLogIn,
                    buttonColor: AppColors.bearSkinTan,
                    textColor: Colors.black,
                    height: height,
                    borderRadius: 15.0,
                    buttonName: 'LOG IN',
                  ),
                  const SizedBox(height: 10,),
                  CustomButton(
                    width: screenWidth * .8,
                    handleButton: handleCreateAccount,
                    buttonColor: Colors.red,
                    textColor: Colors.white,
                    height: height,
                    borderRadius: 15.0,
                    buttonName: 'CREATE ACCOUNT',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyModalSheet extends StatelessWidget {
  const MyModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        child: Container(
          height: screenHeight,
          width: double.infinity,
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Modal Sheet Content'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal sheet
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

