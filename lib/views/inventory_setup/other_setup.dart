import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/utils/scan_barcode.dart';
import 'package:savenote/views/inventory_setup/pantry_setup.dart';
import 'package:savenote/widgets/widget.dart';

class OtherSetup extends StatefulWidget {
  const OtherSetup({Key? key}) : super(key: key);

  @override
  _OtherSetupState createState() => _OtherSetupState();
}

class _OtherSetupState extends State<OtherSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleStr: "Step 2/3",
          action: GestureDetector(
              onTap: () {Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PantrySetup()));},
              child: Text("skip",
                  style:
                  TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 16))),
        ),
        body: Container(

            child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Add freezer items...",
                          suffixIcon:Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/ph_barcode.svg",
                                ),
                                onPressed: ()async {print(await scanBarcode(context));} //do something,
                            ),
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/15,
                  ),
                  Container(
                    child: SvgPicture.asset(
                      'assets/images/other_setup_img.svg',
                        height: MediaQuery.of(context).size.height >
                            MediaQuery.of(context).size.width
                            ? MediaQuery.of(context).size.height / 3.4
                            : MediaQuery.of(context).size.width / 3.4,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/20,
                  ),
                  Text(
                    "Setup your freezer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/24,
                  ),
                  Text("For frozen items such as ice cream, meat,\nfrozen meals, etc.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          height: 2.131,
                          color: Color.fromRGBO(102, 102, 102, 1))),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Finish freezer setup",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(

                    height: MediaQuery.of(context).size.height/20,
                  ),
                ]))));
  }
}
