import 'package:b_love_bear/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AccountsCard extends StatefulWidget {
  final String email;
  final String accountType;
  const AccountsCard({super.key, required this.email, required this.accountType});

  @override
  State<AccountsCard> createState() => _AccountsCardState();
}

class _AccountsCardState extends State<AccountsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.bLOVEBackground,
      shape: RoundedRectangleBorder(
        // side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.email, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(width: 10.0,),
            if(widget.accountType == "request")
              const RequestLayout()
            else if(widget.accountType == "approved")
              const ApprovedAccountsLayout()
            else if(widget.accountType == "blocked")
              const BlockedAccountLayout()
          ],
        ),
      ),
    );
  }
}

class RequestLayout extends StatefulWidget {
  const RequestLayout({super.key});

  @override
  State<RequestLayout> createState() => _RequestLayoutState();
}

class _RequestLayoutState extends State<RequestLayout> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(

          child: Column(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 40,
                  )
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColors.heartRed,
                    size: 40,
                  )
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ApprovedAccountsLayout extends StatefulWidget {
  const ApprovedAccountsLayout({super.key});

  @override
  State<ApprovedAccountsLayout> createState() => _ApprovedAccountsLayoutState();
}

class _ApprovedAccountsLayoutState extends State<ApprovedAccountsLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      CustomButton(
        width: 100,
        handleButton: () {},
        buttonColor: AppColors.bLOVEBackground,
        textColor: Colors.black,
        height: 40,
        borderRadius: 10.0,
        buttonName: "Block",
        borderColor: Colors.black,
        fontSize: 14,
      ),
      ],
    );
  }
}

class BlockedAccountLayout extends StatefulWidget {
  const BlockedAccountLayout({super.key});

  @override
  State<BlockedAccountLayout> createState() => _BlockedAccountLayoutState();
}

class _BlockedAccountLayoutState extends State<BlockedAccountLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          width: 100,
          handleButton: () {},
          buttonColor: AppColors.bLOVEBackground,
          textColor: AppColors.heartRed,
          height: 40,
          borderRadius: 10.0,
          buttonName: "Un-Block",
          borderColor: AppColors.heartRed,
          fontSize: 12,
        ),
      ],
    );
  }
}


