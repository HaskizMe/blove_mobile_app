import 'package:b_love_bear/screens/record_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors/app_colors.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text_field.dart';
import '../global_variables/screen_size_values.dart';
import '../helper_files/accout_creation_helper.dart';
import '../helper_files/login_helper.dart';

class LoginViewPage extends StatefulWidget {
  final Function updateLogin;
  //final Function(BuildContext) showLoading;
  const LoginViewPage({super.key, required this.updateLogin});

  @override
  State<LoginViewPage> createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = 40;
    
    handleSubmitLogin() {
      verifyLogin(context, emailTextController, passwordTextController);
    }


    return Column(
      children: [
        // Your login widgets
        CustomTextField(
          width: ScreenSize.screenWidth * .8,
          textController: emailTextController,
          height: height,
          hintText: "EMAIL ADDRESS",
          isObscure: false,
        ),
        const SizedBox(height: 10,),
        CustomTextField(
          width: ScreenSize.screenWidth * .8,
          textController: passwordTextController,
          height: height,
          hintText: "PASSWORD",
          isObscure: true,
        ),
        const SizedBox(height: 10,),
        CustomButton(
          width: ScreenSize.screenWidth * .8,
          handleButton: widget.updateLogin,
          buttonColor: AppColors.bLOVEBackground,
          textColor: Colors.black,
          height: 40,
          borderRadius: 15.0,
          buttonName: 'CANCEL',
        ),
        const SizedBox(height: 10,),
        CustomButton(
          width: ScreenSize.screenWidth * .8,
          handleButton: handleSubmitLogin,
          buttonColor: AppColors.heartRed,
          textColor: Colors.white,
          height: 40,
          borderRadius: 15.0,
          buttonName: 'SUBMIT',
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}
