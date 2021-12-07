import 'dart:convert';

import 'package:http/http.dart';
import 'package:savenote/constants/api_endpoints.dart';
import 'package:savenote/storage/secure_local_storage.dart';
import 'package:savenote/storage/storage_keys.dart';

class StatisticService {
  Future<Map<String, dynamic>> getWeeklyStat({required id}) async {
    var result;

    var token = await SecureLocalStorage.getItem(TOKEN);
    final Map<String, dynamic> getWeeklyStatBody = {
      'session': token,

    };

    try {
      Response response = await post(
        Uri.parse(ApiEndpoints.getWeeklyStatistics.toString() + '/' + id),
        body: json.encode(getWeeklyStatBody),
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
