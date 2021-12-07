import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/models/household_model.dart';
import 'package:savenote/views/inventory_setup/inventory_setup.dart';
import 'package:savenote/widgets/circular_indicator.dart';
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
  initState() {


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<Household>(builder: (context, householdModel, child) {
      if (!householdModel.loading) {
        return Scaffold(
          appBar: CustomAppBar(
            titleStr: "Create a household",
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Household name",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.black),
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
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GridMembers(false),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: householdName.isNotEmpty
                              ? AppColors.PRIMARY_COLOR
                              : AppColors.SECONDARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 50,
                        child: InkWell(
                          onTap: () async {
                            if (householdName.isNotEmpty) {
                              final loginState = await Provider.of<Household>(
                                  context,
                                  listen: false).createHousehold(hName: householdName);
                              print("ollllalalala");
                                print(loginState);
                              if (loginState['status']) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InventorySetup()));
                              } else {
                                var msg = loginState["message"];
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(msg.toString())));

                            }
                          }
                          },
                          child: Center(
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
                      ),
                    ),
                  ]),
            ),
          ),
        );
      } else {
        return CircularIndicator();
      }
    });
  }
}
