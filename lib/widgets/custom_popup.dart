import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savenote/constants/app_colors.dart';

void customPopup(context, List<String> texts,String imgUri,String buttonText,Function? onDismiss) {
  var widgetList = <Widget>[];
  for (var text in texts) {
    // Add list item
    widgetList.add((Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("• ",style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(text,style: TextStyle(fontSize: 15),),
        ),
      ],
    )));
    widgetList.add(SizedBox(height: 5.0));
  }
  showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return AlertDialog(
          actionsOverflowButtonSpacing: 1 ,
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 19),
          actionsPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          actions: [
            TextButton(

              onPressed: () {
                onDismiss==null ? Navigator.of(context).pop():onDismiss();
              },
              child: Text(buttonText,style:TextStyle(color: AppColors.PRIMARY_COLOR),),
            )
          ],
          content: Container(
            height: MediaQuery.of(context).size.height*.53 ,
            child: SingleChildScrollView (
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Container(
                    child: SvgPicture.asset(
                      imgUri,
                      height: 180,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: widgetList,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
