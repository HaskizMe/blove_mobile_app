import 'dart:async';
import 'package:b_love_bear/custom_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../colors/app_colors.dart';
import '../global_variables/screen_size_values.dart';
import '../helper_files/accout_creation_helper.dart';

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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
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
        const SizedBox(height: 40,),
        // Size of image
        SvgPicture.asset(widget.currentBear, height: ScreenSize.screenHeight * .35, width: ScreenSize.screenWidth * .6,),
        const SizedBox(height: 40,),
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
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController nickNameTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  double height = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bLOVEBackground,
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          onPressed: widget.onBackArrowTapped,
          child: const Row(
            children: [
              Icon(Icons.arrow_back_ios_new, color: AppColors.heartRed),
              SizedBox(width: 2.0),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.heartRed,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.bLOVEBackground,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/bLOVEbEARFrontBig.svg", width: ScreenSize.screenWidth *.3, height: ScreenSize.screenHeight *.3,),
              const SizedBox(height: 40,),

              CustomTextField(
                  width: 300,
                  textController: emailTextController,
                  height: height,
                  hintText: 'EMAIL ADDRESS',
                  isObscure: false
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                  width: 300,
                  textController: nickNameTextController,
                  height: height,
                  hintText: 'NICKNAME',
                  isObscure: false
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                  width: 300,
                  textController: passwordTextController,
                  height: height,
                  hintText: 'PASSWORD',
                  isObscure: true
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                  width: 300,
                  textController: confirmPasswordTextController,
                  height: height,
                  hintText: 'CONFIRM PASSWORD',
                  isObscure: true
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  print("Button tapped!");
                  handleSubmitButton(
                    context,
                    emailTextController,
                    nickNameTextController,
                    passwordTextController,
                    confirmPasswordTextController,
                  );
                },
                hoverColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/HeartSubmitButtonBig.svg',
                  width: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}