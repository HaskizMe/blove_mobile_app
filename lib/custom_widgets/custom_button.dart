import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String buttonName;
  final Function handleButton;
  final Color buttonColor;
  final Color textColor;
  const CustomButton({
    super.key,
    required this.width,
    required this.handleButton,
    required this.buttonColor,
    required this.textColor,
    required this.height,
    required this.borderRadius,
    required this.buttonName
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Making button 80% of screen width
      height: height,
      child: OutlinedButton(
        onPressed: () {
          // Create account on pressed function
          handleButton();
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          ),
          //// FIX COLOR
          backgroundColor: buttonColor,
          side: const BorderSide(color: Colors.black),
        ),
        child: Text(buttonName, style: TextStyle(color: textColor, fontSize: 18),),
      ),
    );
  }
}
