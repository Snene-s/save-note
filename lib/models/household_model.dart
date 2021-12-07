
import 'package:flutter/foundation.dart';
import 'package:savenote/Services/household_service.dart';
import 'package:savenote/models/member.dart';

class Household extends ChangeNotifier {
  List members = [];
  String name = "";
  bool _isLoading = false;
  bool get loading => _isLoading;
  final HouseholdService householdService = HouseholdService();

  getMembers() async {
    return members;
  }

  logout()  {
     members=[];
     name = "";
  }
  Future addMember({String? name, required String email, String? phone}) async {
    members.add(new Member(
        email: email, username: name, phone: phone));

    notifyListeners();
    return members;
  }

  Future createHousehold({required String hName}) async {
    this._isLoading = true;
    notifyListeners();
    var response = await householdService.createHousehold(
        name: hName, emails: members.map((member) => member.email).toList());
    if (response["status"]) {

      print(response);
      var subscribedUsersJson= response["data"]["subcribed_user"];

      print(subscribedUsersJson);

      var subscribedUsers = response["data"]["subcribed_user"]
          .map((ele) => Member.fromJson(ele))
          .toList();

      members = [...subscribedUsers];
    }
    this._isLoading = false;

    notifyListeners();
    return response;
  }

  Future getHousehold({required String id}) async {
    this._isLoading = true;
    notifyListeners();
    var response = await householdService.getHousehold(id: id);

    if (response["status"]) {
      print (response);
     var subscribedUsersJson= response["data"]["subcribed_user"];

      print(subscribedUsersJson);

      var subscribedUsers = response["data"]["subcribed_user"]
          .map((ele) => Member.fromJson(ele))
          .toList();


      members = [...subscribedUsers];
    }
    this._isLoading = false;
    notifyListeners();
    return members;
  }

  Map<String, dynamic> toJson() => {
        "memberList": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}
