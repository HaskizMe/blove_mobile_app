import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final Color? fontColor;
  final bool bottomBorder;
  final VoidCallback onTapCallback;

  const CustomTile({
    super.key,
    this.fontColor,
    required this.title,
    required this.bottomBorder,
    required this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: onTapCallback,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                child: Text(
                  title,
                  style: TextStyle(color: fontColor ?? Colors.black),
                ),
              ),
              contentPadding: EdgeInsets.zero,
              tileColor: Colors.white,
            ),
          ),
        ),
        if (bottomBorder) const Divider(color: Colors.black, thickness: 0.3, height: 0,),
      ],
    );
  }
}
