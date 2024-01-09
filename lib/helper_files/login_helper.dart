import 'package:b_love_bear/custom_widgets/custom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../screens/record_screen.dart';
import 'alert_dialog_helper.dart';


void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CustomLoader(text: 'ATTEMPTING\n      LOGIN',)
      );
    },
  );
}

void verifyLogin(BuildContext context, TextEditingController emailController, TextEditingController passwordController){
  String password = passwordController.text;
  String email = emailController.text;
  String error = '';
  String solution = '';

  if(email.isEmpty){
    error = "Missing Email";
    solution = "Please input your email";
    showErrorDialog(context, error, solution);
  }
  else if(password.isEmpty){
    error = "Missing Password";
    solution = "Please input your password";
    showErrorDialog(context, error, solution);
  }
  else {
    // Show loading circle
    showLoading(context);
    // Simulate a delay (e.g., for a network request)
    Future.delayed(const Duration(milliseconds: 2000), () {
      // Hide loading circle
      if(email == 'b' && password == 'b'){
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RecordPage()),);
        print("submit button clicked");
      }
      else{
        error = "Login Error";
        solution = "Could not log in with provided credentials";
        Navigator.of(context).pop();
        showErrorDialog(context, error, solution);
      }
    });
  }
}