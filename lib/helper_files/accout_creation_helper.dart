import 'package:b_love_bear/colors/app_colors.dart';
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String errorString, String solutionString) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(errorString),
        content: Text(solutionString),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Dismiss the dialog
            },
            child: Text('DISMISS', style: TextStyle(color: AppColors.heartRed),),
          ),
        ],
      );
    },
  );
}

void handleSubmitButton(BuildContext context, TextEditingController emailController, TextEditingController nicknameController, TextEditingController passwordController, TextEditingController confirmPasswordController,) {
  String password = passwordController.text;
  String confirmPassword = confirmPasswordController.text;
  String email = emailController.text;
  String nickName = nicknameController.text;
  String error = '';
  String solution = '';

  if(email.isEmpty){
    error = "Missing Email";
    solution = "Please enter a valid email to create your account";
    showErrorDialog(context, error, solution);
  }
  else if(nickName.isEmpty) {
    error = "Missing Nick Name";
    solution = "Please input a nick name so that you can be identified when sending messages";
    showErrorDialog(context, error, solution);
  }
  else if(password.isEmpty){
    error = "Missing Password";
    solution = "Please input a password, it must be at least 6 characters";
    showErrorDialog(context, error, solution);
  }
  else if(password.length < 6){
    error = "Invalid Password";
    solution = "Your password must be at least 6 characters";
    showErrorDialog(context, error, solution);
  }
  else if(confirmPassword.isEmpty){
    error = "Confirm Password";
    solution = "Please confirm your password";
    showErrorDialog(context, error, solution);
  }
  else if (password != confirmPassword) {
    // Passwords don't match, show error dialog
    error = "Password Does Not Match";
    solution = "Your password doesn't match. Please re-enter your password";
    showErrorDialog(context, error, solution);
  }
  else {
    // Successful account creation

    // Print the values for testing
    print("Email: ${emailController.text}");
    print("Nickname: ${nicknameController.text}");
    print("Password: $password");
    print("Confirm Password: $confirmPassword");
  }
}