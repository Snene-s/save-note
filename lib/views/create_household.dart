import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/models/member_list.dart';
import 'package:savenote/views/inventory_setup/inventory_setup.dart';
import 'package:savenote/views/invite_member.dart';
import 'package:savenote/widgets/grid_members.dart';
import 'package:savenote/widgets/widget.dart';

class CreateHousehold extends StatefulWidget {
  const CreateHousehold({Key? key}) : super(key: key);

  @override
  _CreateHouseholdState createState() => _CreateHouseholdState();
}

class _CreateHouseholdState extends State<CreateHousehold> {
  String householdName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleStr: "Create a household",
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Household name",
              style: TextStyle(
                  fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
                onChanged: (val) {
                  householdName = val;
                },
                decoration: CommonStyle.textFieldStyle(
                  hintTextStr: 'Enter your household name...',
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "Household members",
              style: TextStyle(
                  fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            GridMembers(),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                householdName.isNotEmpty
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InventorySetup()))
                    : null;
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                decoration: BoxDecoration(
                  color: householdName.isNotEmpty
                      ? AppColors.PRIMARY_COLOR
                      : AppColors.SECONDARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
