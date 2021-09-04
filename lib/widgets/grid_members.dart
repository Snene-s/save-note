import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/member_list.dart';
import 'package:savenote/views/invite_member.dart';


class GridMembers extends StatelessWidget {
  const GridMembers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<MemberList>(context, listen: false).getMembers();
    return  Consumer<MemberList>(
        builder: (context, membersModel, child){
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
                                      builder: (context) => InviteMember()));},
                          ),
                        ));
                  }
                  return CircleAvatar(
                    backgroundColor: AppColors.BORDER_COLOR,
                    child: CircleAvatar(
                      radius: 40.2,
                      backgroundColor: Color(membersModel.members[index].color).withOpacity(1.0),
                      child:Text(membersModel.members[index].name.substring(0,2).toUpperCase(),style: TextStyle(fontSize: 28,color: Colors.white),)
                    ),
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
