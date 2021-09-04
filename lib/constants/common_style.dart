import 'package:flutter/material.dart';
import 'package:savenote/constants/app_colors.dart';

class CommonStyle {
  static InputDecoration textFieldStyle(
      {String hintTextStr = "", Widget? suffix,String? errorMessage}) {
    return InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: hintTextStr,
        errorText: errorMessage,
        suffixIcon: suffix,
        hintStyle: TextStyle(
            fontSize: 14, fontFamily: 'Roboto', color: AppColors.BORDER_COLOR),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: AppColors.BORDER_COLOR),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.PRIMARY_COLOR, width: 0.5)));
  }
}
