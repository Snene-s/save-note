import 'package:flutter/material.dart';
import 'package:savenote/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String titleStr;
  Widget? action;
   CustomAppBar({Key? key, required this.titleStr,this.action}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        titleStr,
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: AppColors.TEXT_COLOR),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB( 0,21,28,15),
          child:action,
        )
      ],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context, true);
        },
      ),
      brightness: Brightness.light,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
