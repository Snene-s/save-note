import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:savenote/Services/auth_service.dart';
import 'package:savenote/models/user.dart';

class AuthModel extends ChangeNotifier {
  bool _isLoading = false;
  final AuthService authService = AuthService();
  bool get loading => _isLoading;
  User? user;
  List<String> householdId=[];

  submitLogin({@required email, @required password}) async {
    this._isLoading = true;
    notifyListeners();
    var response = await authService.login(email: email, password: password);
    print(response);
    if (response["status"]) {
      user = User.fromJson(response["user"]);
      var admin=response["user"]?["admin_of"] == null
      ? []
    : [response["user"]["admin_of"]];

    var memberIn=response["user"]?["Member_in"] == null
    ? []
        : [response["user"]["Member_in"]];
    householdId = [...admin,...memberIn];
    }

    this._isLoading = false;
    notifyListeners();

    return response;
  }

  forgotPasswordStepOne({@required email}) async {
    this._isLoading = true;
    notifyListeners();
    var response = await authService.forgotPasswordStepOne(email: email);
    print(response);
    this._isLoading = false;
    notifyListeners();

    return response;
  }
  // forgotPasswordStepTwo ({@required email}) async{
  //
  //   this._isLoading =true;
  //   notifyListeners();
  //   var response = await authService.forgotPasswordStepOne(email: email);
  //   print(response);
  //   this._isLoading =false;
  //   notifyListeners();
  //
  //   return response;
  //
  // }

  submitSignUp({
    @required email,
    @required password,
    @required userName,
    @required passwordConfirmation,
  }) async {
    this._isLoading = true;
    notifyListeners();

    var response = await authService.register(
        userName: userName,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation);

    this._isLoading = false;
    if (response["status"]) {
      user = User.fromJson(response["user"]);
    }
    print(user);
    notifyListeners();
    return response;
  }

  logout() async {
    this._isLoading = true;

    await authService.logOut();

    this._isLoading = false;
      notifyListeners();
  }
  getHouseHoldId(){
    return householdId;
  }


  Future<bool> getUser() async {
    if (user != null) return true;

    var response = await authService.getCurrentUser();
    print(response);
    if (response["status"]) {
      user = User.fromJson(response["user"]);
      var admin=response["user"]?["admin_of"] == null
          ? []
          : [response["user"]["admin_of"]];

    var memberIn=response["user"]?["Member_in"] == null
    ? []
        : [response["user"]["admin_of"]];
      householdId = [...admin,...memberIn];
      print(user!.color);
      inspect(user);
       inspect(householdId);
      return true;
    }
    await authService.logOut();

    return false;
  }
}
