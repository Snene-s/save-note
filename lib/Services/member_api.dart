import 'dart:convert';

import 'package:http/http.dart';

class MemberRep {

  static const String _baseUrl = "https://jsonplaceholder.typicode.com/users";


  Future<Map<String, dynamic>> getAllMembers () async{

    var result;
    try{
      Response response = await get(Uri.parse(_baseUrl)
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List responseData = json.decode(response.body);
        result = {'status': true, 'data': responseData};
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



}
