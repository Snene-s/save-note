import 'dart:convert';

import 'package:http/http.dart';
import 'package:savenote/constants/api_endpoints.dart';
import 'package:savenote/storage/secure_local_storage.dart';
import 'package:savenote/storage/storage_keys.dart';

class HouseholdService {
  Future<Map<String, dynamic>> createHousehold({required name, emails}) async {
    var result;
    var token = await SecureLocalStorage.getItem(TOKEN);
    final Map<String, dynamic> createHouseholdBody = {
      'session': token,
      'name': name,
      'emails': emails ?? []
    };

    try {
      Response response = await post(
        ApiEndpoints.createHousehold,
        body: json.encode(createHouseholdBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        result = {
          'status': true,
          'message': responseData['message'],
          'data': responseData
        };

        return result;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        result = {'status': false, 'message': responseData["message"]};
      }
    } catch (e) {
      print(e);
      return {'status': false, 'message': "http error "};
    }
    return result;
  }

  Future<Map<String, dynamic>> inviteMember({required email}) async {
    var result;
    var token = await SecureLocalStorage.getItem(TOKEN);
    final Map<String, dynamic> addMemberBody = {
      'session': token,
      'email': email
    };

    try {
      Response response = await post(
        ApiEndpoints.addMember,
        body: json.encode(addMemberBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // print(responseData.runtimeType);

        result = {
          'status': true,
          'message': 'Successful',
          'data': responseData
        };

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

  Future<Map<String, dynamic>> getHousehold({required id}) async {
    var result;

    var token = await SecureLocalStorage.getItem(TOKEN);
    final Map<String, dynamic> getHouseholdBody = {
      'session': token,

    };
    if (id==null)return {'status': false, 'message': 'Something wrong'};
    try {
      Response response = await post(
        Uri.parse(ApiEndpoints.getHousehold.toString() + '/' + id),
        body: json.encode(getHouseholdBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        result = {
          'status': true,
          'message': 'Successful',
          'data': responseData
        };

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
}
