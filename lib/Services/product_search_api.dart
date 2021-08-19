import 'dart:convert';

import 'package:http/http.dart';
import 'package:savenote/constants/api_endpoints.dart';
import 'package:savenote/models/product.dart';

class ProductSearchRep{

  Future<Map<String, dynamic>> search (String word) async{

    var result;
    try{
      Response response = await get(Uri.parse(ApiEndpoints.searchFridgeItemsApi+"&query=$word"));
      if (response.statusCode == 200) {
        final  Map<String, dynamic> responseData = json.decode(response.body);
        List<Product> products=parseProducts(responseData['foods']);
        result = {'status': true, 'data':products ,'totalHits':responseData["totalHits"]};
        return result;
      }
      else {
        result = {
          'status': false,
          'message': response.body
        };

      }

    }
    catch(e){
      print(e);
      return {
        'status': false,
        'message': "an http error occured"
      };
    }

    return result;
  }
  static List<Product>parseProducts(List<dynamic> responseBody){
    var data =responseBody.map((x)=>Product.fromJson(x));
    return data.toList();
  }

}