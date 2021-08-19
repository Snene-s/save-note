import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/widgets/widget.dart';

import 'fridge_setup.dart';

class InventorySetup extends StatefulWidget {
  const InventorySetup({Key? key}) : super(key: key);

  @override
  _InventorySetupState createState() => _InventorySetupState();
}

class _InventorySetupState extends State<InventorySetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleStr: "Inventory Setup",
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "We’ve developed a quick, guided walk-through to see what you currently have in stock and/or what you usually keep on hand but might be out.This will help us start creating your grocery predictions right away.\nYou can save your progress at any time.",
              style:
                  TextStyle(height: 2, fontSize: 14, fontFamily: 'Roboto'),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Image.asset(
                'assets/images/inventory_setup_img.png',
                width: 270,
                height: 270,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FridgeSetup()));
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Let's go",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
