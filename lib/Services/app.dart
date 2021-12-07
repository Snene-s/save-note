import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/Services/auth_service.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/storage/secure_local_storage.dart';
import 'package:savenote/storage/storage_keys.dart';
import 'package:savenote/views/home.dart';
import 'package:savenote/views/inventory_setup/inventory_setup.dart';
import 'package:savenote/views/no_internet_screen.dart';
import 'package:savenote/views/welcome.dart';






final AuthService authService = AuthService();
Future<Widget> getStartUpScreen( {BuildContext? context}) async {
  Map profile;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Connected to Internet');
    } else {
      return NoInternetScreen();
    }
  } on SocketException catch (_) {
    return NoInternetScreen();
  }



  // Check reset token exists
  try {
    String? resetToken =await SecureLocalStorage.getItem(TOKEN);
    if (resetToken == null) {
      return Welcome(); // Login page
    }
  } catch (error) {
    return Welcome(); // Login page
  }

  // Fetch and store accessToken in localStorage
  try {
    await Provider.of<AuthModel>(context!, listen: false).getUser();
    return Home();
    //return InventorySetup();
  } catch (error) {
    await  authService.logOut();
    return Welcome(); // Login page
  }


}

