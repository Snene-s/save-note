import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/household_model.dart';
import 'package:savenote/views/invite_member.dart';
import 'package:savenote/widgets/circular_indicator.dart';

toColor(String color) {

  var hexColor = color.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }

  return Color(0xFFB0BEC5);
}

class GridMembers extends StatelessWidget {
  final bool isList;

  GridMembers(this.isList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Household>(builder: (context, membersModel, child) {
      if (membersModel.loading)
        return Container(
          child: CircularIndicator(),
        );

      return SizedBox(
          height: 300,
          child: GridView.builder(
            itemBuilder: (context, index) {
              if (index == membersModel.members.length) {
                return CircleAvatar(
                    backgroundColor: AppColors.BORDER_COLOR,
                    child: CircleAvatar(
                      radius: 40.2,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Color.fromRGBO(153, 153, 153, 1),
                        ),
                        iconSize: 40,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InviteMember()));
                        },
                      ),
                    ));
              }
              return CircleAvatar(
                backgroundColor: AppColors.BORDER_COLOR,
                child: CircleAvatar(
                    radius: 40.2,
                    backgroundColor: toColor(membersModel.members[index].color)
                        .withOpacity(1.0),
                    child: Text(
                      membersModel.members[index].username
                          .substring(0, 2)
                          .toUpperCase(),
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    )),
              );
            },
            itemCount: membersModel.members.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 11.0),
          ));
    });
  }
}
