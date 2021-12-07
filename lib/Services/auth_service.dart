import 'dart:convert';

import 'package:http/http.dart';
import 'package:savenote/constants/api_endpoints.dart';
import 'package:savenote/storage/secure_local_storage.dart';
import 'package:savenote/storage/storage_keys.dart';

class AuthService {
  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };
    try {
      Response response = await post(
        ApiEndpoints.login,
        body: json.encode(loginData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
         print(responseData);

        result = {
          'status': true,
          'message': 'Successful',
          'user': responseData
        };

        await storeToken(responseData);

        return result;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        result = {'status': false, 'message': responseData["message"]};
      }
    } catch (e) {
      print(e);
      return {'status': false, 'message': 'No internet connection'};
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
      {required String userName,
      required String email,
      required String password,
      required String passwordConfirmation}) async {
    var result;

    try {
      final Map<String, dynamic> signupData = {
        'username': userName,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };

      Response response = await post(
        ApiEndpoints.register,
        body: json.encode(signupData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return await login(email: email, password: password);
      } else {
        print(json.decode(response.body));
        return {
          'status': false,
          'message': json.decode(response.body)["message"]
        };
      }
    } catch (e) {
      print(e);
      return {'status': false, 'message': 'No internet connection'};
    }
    return result;
  }

  /// ForgotPassword service
  Future<Map<String, dynamic>> forgotPasswordStepOne({
    required String email,
  }) async {
    var result;

    try {
      final Map<String, dynamic> forgot = {
        'email': email,
      };

      Response response = await post(
        ApiEndpoints.forgotPassword,
        body: json.encode(forgot),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        result = {'status': true, 'message': responseData["message"]};

        return result;
      } else {
        result = {
          'status': false,
          'message': json.decode(response.body)["errors"].toString()
        };
      }
    } catch (e) {
      print(e);
      return {'status': false, 'message': 'No internet connection'};
    }
    return result;
  }

  Future storeToken(Map<String, dynamic> responseData) async {
    try {
      String accessToken = responseData['session'];
      print(accessToken);

      await SecureLocalStorage.setItem(TOKEN, accessToken);
    } catch (e) {
      print(e);
    }
  }

  Future logOut() async {
    try {
      await SecureLocalStorage.deleteItem(TOKEN);
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    var result;

    try {
      String? token = await SecureLocalStorage.getItem(TOKEN);
      //print(token);
      Response response = await post(
        ApiEndpoints.user,
        body: json.encode({"session":token}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);

        return {
          'status': true,
          'message': 'Successful',
          'user': responseData
        };
      } else {
      result = {
         'status': false,
         'message': json.decode(response.body)["message"].toString()

      };}
    } catch (e) {
      print(e);
      return {"error": "error occured"};
    }
    return result;
  }
}
