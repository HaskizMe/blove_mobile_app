import 'dart:async';
import 'package:flutter/material.dart';

import '../global_variables/screen_size_values.dart';

handleNavigation(Widget navigateToWidget, BuildContext context) async {
  Completer<bool> modalClosedCompleter = Completer<bool>();
  // Shows a Scrollable sheet for easy navigation. User can swipe down to get rid of sheet
  print('Modal sheet opened...');
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
        builder: (recordPageContext, scrollController) {
          return navigateToWidget;
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