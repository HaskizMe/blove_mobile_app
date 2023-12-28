import 'package:b_love_bear/custom_widgets/accounts_card.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../global_variables/screen_size_values.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return const ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      child: Scaffold(
        // backgroundColor: AppColors.bLOVEBackground,
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start, // Add this line
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                  child: Text(
                      "Requests",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
              ),
              AccountsCard(email: "MckennaColeman@gmail.com", accountType: 'request',),
              AccountsCard(email: "BaileyHaskeasdfasdfasdfasdfll@gmail.com", accountType: 'request',),
              // FriendRequestCard(email: "Haskellb2017@gmail.com"),
              // FriendRequestCard(email: "Haskellb20dsalfgiohsadfl;kijhsadfoilh;sdgh;ijlosdghlo;igdfshio;dgfsh;ilogdsa;hloigdsafh;jlnkgsd17@gmail.com"),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Approved Accounts",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              AccountsCard(email: "MckennaColeman@gmail.com", accountType: 'approved',),
              AccountsCard(email: "BaileyasdfasdfasdfHaskell@gmail.com", accountType: 'approved',),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Blocked Accounts",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              AccountsCard(email: "MckennaColeman@gmail.com", accountType: 'blocked',),
              AccountsCard(email: "BaileyHdsfgasdfasdfasdfaskell@gmail.com", accountType: 'blocked',),

            ],
          ),
        ),
      ),
    );
  }
}
