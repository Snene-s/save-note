import 'package:flutter/material.dart';
import 'package:savenote/constants/app_colors.dart';
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
          titleStr: "Step 3/3",
          action: GestureDetector(
              onTap: () {},
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
                      'assets/images/other_setup_img.png',
                      width: 231.26,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Add other items",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("For cleaning supplies, sanitary \nproducts, etc.",
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
                      "Finish setup",
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
