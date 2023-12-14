import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double width;
  final TextEditingController textController;
  final double height;
  final String hintText;
  final bool isObscure;
  const CustomTextField({
    super.key,
    required this.width,
    required this.textController,
    required this.height,
    required this.hintText,
    required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        textAlign: TextAlign.center,
        cursorColor: Colors.grey,
        controller: textController,
        obscureText: isObscure,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: height / 2 - 16, horizontal: 10),
          focusColor: Colors.black,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                  color: Colors.black
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                  color: Colors.black
              )
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
