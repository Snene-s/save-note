import 'package:flutter/foundation.dart';
import 'package:savenote/Services/member_api.dart';
import 'package:savenote/models/member.dart';
import 'dart:math' ;

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

    for(int i =0; i<2;i++){
        members.add(Member.fromJson(allMembers[i], (new Random().nextDouble() * 0xFFFFFF).toInt()));

    }
    notifyListeners();

    return members;
  }
  Future addMember({required String name, required String email, required String phone}) async{

    members.add(new Member(email: email,name: name,phone:phone,color:  (new Random().nextDouble() * 0xFFFFFF).toInt()));

    notifyListeners();
    return members;

  }

  Map <String,dynamic> toJson()=>{
    "memberList":List<dynamic>.from(members.map((x)=>x.toJson())),
  };
}
