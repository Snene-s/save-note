import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:savenote/constants/api_endpoints.dart';
import 'package:savenote/models/product.dart';

class ProductSearchRep {
  Future<Map<String, dynamic>> search(String word) async {
    var result;
    print(word);
    final Map<String, String> getProductBody = {
      'name': word,
    };
    try {
      Response response = await post(
        ApiEndpoints.getProductInfo,
        body: json.encode(getProductBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        print(responseData);
        result = {'status': true, 'data': responseData};
        return result;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        result = {'status': false, 'message': responseData["message"]};
      }
    } catch (e) {
      print(e);
      return {'status': false, 'message': "an http error occurred"};
    }

    return result;
  }
  Future<Map<String, dynamic>> searchByCode(String code) async {
    var result;
    print(code);
    final Map<String, String> getProductBody = {
      'code': code,
    };
    try {
      Response response = await post(
        ApiEndpoints.searchBarCode,
        body: json.encode(getProductBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        print(responseData);
        result = {'status': true, 'data': responseData[0]};
        return result;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        result = {'status': false, 'message': responseData["message"]};
      }
    } catch (e) {
      print(e);
      return {'status': false, 'message': "an http error occurred"};
    }

    return result;
  }
  static List<Product> parseProducts(List<dynamic> responseBody) {
    var data = responseBody.map((x) => Product.fromJson(x));
    return data.toList();
  }
}
