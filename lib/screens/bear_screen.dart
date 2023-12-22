import 'package:b_love_bear/custom_widgets/bear_card.dart';
import 'package:b_love_bear/helper_files/data_managment.dart';
import 'package:b_love_bear/screens/record_screen.dart';
import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class Bears extends StatefulWidget {
  const Bears({super.key});

  @override
  State<Bears> createState() => _BearsState();
}

class _BearsState extends State<Bears> {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
      child: Scaffold(
        backgroundColor: AppColors.bLOVEBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
          child: ListView.builder(
            itemCount: bears.length,
            itemBuilder: (BuildContext context, int index) {
              final bear = bears[index];
              return GestureDetector(
                onTap: () {
                  print('${bear.name} is selected');
                  setState(() {
                    // This sees if there are any bears selected
                    if(bears.any((selectedBear) => selectedBear.isSelected)) {
                      // If yes then finds the index of the selected bear and deselects it
                      int indexOfSelectedBear = bears.indexWhere((bear) => bear.isSelected);
                      bears[indexOfSelectedBear] = BearCard(isSelected: false, name: bears[indexOfSelectedBear].name);

                      // This selects the new bear
                      bears[index] = BearCard(isSelected: true, name: bear.name);
                    }
                  });
                  // Closes window and goes to record page
                  Navigator.pop(context);
                },
                child: bears[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
