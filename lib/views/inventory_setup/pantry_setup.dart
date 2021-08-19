import 'package:flutter/material.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/views/inventory_setup/other_setup.dart';
import 'package:savenote/widgets/widget.dart';

class PantrySetup extends StatefulWidget {
  const PantrySetup({Key? key}) : super(key: key);

  @override
  _PantrySetupState createState() => _PantrySetupState();
}

class _PantrySetupState extends State<PantrySetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleStr: "Step 2/3",
          action: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OtherSetup()));
              },
              child: Text("skip",
                  style:
                      TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 16))),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
                child: Column(children: [
              TextField(
                decoration: InputDecoration(
                    hintText: "Search anything...",
                    suffixIcon: Icon(
                      Icons.qr_code_2_outlined,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: AppColors.BORDER_COLOR),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                          color: AppColors.BORDER_COLOR,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.BORDER_COLOR, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(24)))),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                child: Image.asset(
                  'assets/images/pantry_setup_img.png',
                    width: 231.26,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Setup your pantry",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              Text("For dry food items such as rice,\noil,flour, etc.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      height: 2.131,
                      color: Color.fromRGBO(102, 102, 102, 1))),
              SizedBox(
                height: 70,
              ),

              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                decoration: BoxDecoration(
                  color: AppColors.SECONDARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Setup pantry",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),

            ]))));
  }
}
