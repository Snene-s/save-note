import 'package:flutter/foundation.dart';
import 'package:savenote/Services/member_api.dart';
import 'package:savenote/models/member.dart';
import 'dart:convert';

class MemberList extends ChangeNotifier {
  List members =[];
  final memberRep = MemberRep();
  bool _isLoading = false;
  bool get loading => _isLoading;

  getMembers() async{
    if (members.length!=0)
      return members;
    var membersFromApi = await memberRep.getAllMembers();


    members=[];
    print("///////////////////////////////////"
        "reload"
        "/////////////////////////////////////"
    );
    List allMembers = membersFromApi["data"] ;

    for(int i =0; i<allMembers.length;i++){
        members.add(Member.fromJson(allMembers[i]));

    }
    notifyListeners();

    return members;
  }
  Future addMember({required String name, required String email, required String phone}) async{

    members.add(new Member(email: email,name: name,phone:phone));

    notifyListeners();
    return members;

  }

  Map <String,dynamic> toJson()=>{
    "memberList":List<dynamic>.from(members.map((x)=>x.toJson())),
  };
}
