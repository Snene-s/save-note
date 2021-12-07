import 'package:flutter/material.dart';
import 'package:savenote/constants/app_colors.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child :
      Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(AppColors.PRIMARY_COLOR),),),
    );
  }
}