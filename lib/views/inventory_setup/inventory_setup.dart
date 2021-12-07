import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              Text(
                "We’ve developed a quick, guided walk-through to see what you currently have in stock and/or what you usually keep on hand but might be out.This will help us start creating your grocery predictions right away.\nYou can save your progress at any time.",
                style: TextStyle(height: 2, fontSize: 14, fontFamily: 'Roboto'),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                child: SvgPicture.asset('assets/images/inventory_setup_img.svg',
                    height: MediaQuery.of(context).size.height >
                            MediaQuery.of(context).size.width
                        ? MediaQuery.of(context).size.height / 3.4
                        : MediaQuery.of(context).size.width / 3.4),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,

                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),

                child:Ink(
                  decoration: BoxDecoration(
                    color: AppColors.PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FridgeSetup()));
                  },
                  child: Center(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
