import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../helper_files/navigation_helper.dart';
import '../screens/accounts_screen.dart';
import '../screens/bear_screen.dart';
import '../screens/sent_messages_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/setup_bear_screen.dart';
import '../screens/received_messages_screen.dart';
import 'ios_style_action_menu.dart';

class MenuNavigation extends StatefulWidget {
  final BuildContext recordPageContext;
  final VoidCallback rebuildRecordPage; // Callback to trigger a rebuild
  final double iconSize;
  const MenuNavigation({
    super.key,
    required this.recordPageContext,
    required this.rebuildRecordPage,
    required this.iconSize
  });

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  @override
  Widget build(BuildContext context) {
    handleLogOut() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: widget.recordPageContext,
          builder: (BuildContext context) {
            return const CustomActionSheet();
          }
      );
    }

    return PopupMenuButton<String>(
      icon: Icon(Icons.menu, size: widget.iconSize,),
      onSelected: (value) {
        // Handle menu item selection
        if (value == 'sentMessages') {
          handleNavigation(const SentMessages(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'receivedMessages') {
          handleNavigation(const ReceivedMessages(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'bears') {
          handleNavigation(const Bears(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'accounts'){
          handleNavigation(const Accounts(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'setupBear'){
          handleNavigation(const SetupBear(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'logout'){
          handleLogOut();
        } else {
          print("Pop up Menu doesn't contain that string name");
        }
        // Add more conditions for other menu items
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'sentMessages',
          child: ListTile(
            leading: Icon(Icons.send),
            title: Text('Sent Messages'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'receivedMessages',
          child: ListTile(
            leading: Icon(Icons.mail),
            title: Text('Received Messages'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'bears',
          child: ListTile(
            leading: Icon(Icons.pets),
            title: Text('Bears'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'accounts',
          child: ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Accounts'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'setupBear',
          child: ListTile(
            leading: Icon(Icons.cached),
            title: Text('Setup Bear'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout, color: AppColors.heartRed,),
            title: Text('Logout', style: TextStyle(color: AppColors.heartRed),),
          ),
        ),
        // Add more menu items as needed
      ],
    );
  }
}