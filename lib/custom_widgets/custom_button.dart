import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String buttonName;
  final Function handleButton;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  const CustomButton({
    super.key,
    required this.width,
    required this.handleButton,
    required this.buttonColor,
    required this.textColor,
    required this.height,
    required this.borderRadius,
    required this.buttonName,
    required this.borderColor,
    required this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: () {
          // Create account on pressed function
          handleButton();
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)
          ),
          backgroundColor: buttonColor,
          side: BorderSide(color: borderColor),
        ),
        child: Text(
          buttonName,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
