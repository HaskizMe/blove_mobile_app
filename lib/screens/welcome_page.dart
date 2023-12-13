import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../colors/app_colors.dart';
import '../custom_widgets/custom_button.dart';
import '../global_variables/screen_size_values.dart';
import 'create_account_page.dart';
import 'login_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // final Completer<bool> _modalClosedCompleter = Completer<bool>();
  final String bLoveBearLogo = 'assets/bLOVEbEARLogoWTypeEdit.svg';
  bool isCreatingAccount = false;
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    double height = 40;

    // Function to handle logging in
    handleLogIn() {
      setState(() {
        isLoggingIn = !isLoggingIn;
      });
    }

    // Function to handle creating an account
    handleCreateAccount() async {
      Completer<bool> modalClosedCompleter = Completer<bool>();
      // Shows screen pop up to make account
      await showModalBottomSheet(
        constraints: BoxConstraints(
          maxWidth: ScreenSize.screenWidth
        ),
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.95,
            expand: true,
            builder: (context, scrollController) {
              return const CreateAccount();
            },
          );
        },
      ).whenComplete(() {
        // The modal sheet is closed
        print('Closing modal sheet...');
        if (!modalClosedCompleter.isCompleted) {
          modalClosedCompleter.complete(true);
        }
      });
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
                fontFamily: 'roboto-light',
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 20,),
            // bLOVE image
            SvgPicture.asset(
              bLoveBearLogo,
              width: ScreenSize.screenWidth * .6, // Size of image based on screen width
              height: ScreenSize.screenWidth * .6, // Size of image based on screen width
            ),
            const SizedBox(height: 60,),

            // Switches between login and create account views
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: isLoggingIn
                  ? LoginViewPage(updateLogin: handleLogIn,) : WelcomeView(updateLogin: handleLogIn, updateCreateAccount: handleCreateAccount,)
            )
          ],
        ),
      ),
    );
  }
}

class WelcomeView extends StatelessWidget {
  final Function updateLogin;
  final Function updateCreateAccount;
  const WelcomeView({super.key, required this.updateLogin, required this.updateCreateAccount});

  @override
  Widget build(BuildContext context) {
    double height = 40;

    return Column(
      children: [
        // Your non-login widgets
        CustomButton(
          width: ScreenSize.screenWidth * .8,
          handleButton: updateLogin,
          buttonColor: AppColors.bearSkinTan,
          textColor: Colors.black,
          height: height,
          borderRadius: 15.0,
          buttonName: 'LOG IN',
        ),
        const SizedBox(height: 10,),
        CustomButton(
          width: ScreenSize.screenWidth * .8,
          handleButton: updateCreateAccount,
          buttonColor: Colors.red,
          textColor: Colors.white,
          height: height,
          borderRadius: 15.0,
          buttonName: 'CREATE ACCOUNT',
        ),
      ],
    );
  }
}


