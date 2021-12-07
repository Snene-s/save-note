import 'dart:convert';

import 'package:http/http.dart';
import 'package:savenote/constants/api_endpoints.dart';
import 'package:savenote/storage/secure_local_storage.dart';
import 'package:savenote/storage/storage_keys.dart';

class InventoryService {
  Future<Map<String, dynamic>> addProductsToInventory(
      {required String type, required products}) async {
    var result;

    var token = await SecureLocalStorage.getItem(TOKEN);
    final Map<String, dynamic> body = {
      'session': token,
      'products': products,
      'type': type
    };
    try {
      Response response = await post(
        ApiEndpoints.addInventory,
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);

        result = {
          'status': true,
          'message': 'Successful',
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



  Future<Map<String, dynamic>> getInventory( String id
     ) async {
    var result;

    var token = await SecureLocalStorage.getItem(TOKEN);
    final Map<String, dynamic> body = {
      'session': token,
    };
    try {
      Response response = await post(
         ( Uri.parse(ApiEndpoints.getInventory.toString() + '/' + id)),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);

        result = {
          'status': true,
          'data': responseData,
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
