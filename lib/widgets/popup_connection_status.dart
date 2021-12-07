import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savenote/constants/app_colors.dart';

void popupConnectionStatus(context) {
  showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsOverflowButtonSpacing: 1,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 19),
          actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          actions: [
            TextButton(
              onPressed: () async {
                var connection = await _checkInternetConnection();
                if (connection) Navigator.of(context).pop();
              },
              child: Text(
                "Try again",
                style: TextStyle(color: AppColors.PRIMARY_COLOR),
              ),
            )
          ],
          content: Container(
            height: MediaQuery.of(context).size.height * .40,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: SvgPicture.asset(
                      "assets/images/noInternet.svg",
                      height: MediaQuery.of(context).size.height * .30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Text("No internet connection!",
                          style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Please check your internet connection",
                          style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Future<bool> _checkInternetConnection() async {
  try {
    final response = await InternetAddress.lookup('www.kindacode.com');
    if (response.isNotEmpty) {
      return true;
    }
  } on SocketException catch (err) {
    return false;
  }
  return false;
}
