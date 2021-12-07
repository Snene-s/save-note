import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureLocalStorage {

  static final  _secureStorage = FlutterSecureStorage();


  static Future setItem(String key, String value) async {

    await _secureStorage.write(key:key, value:value);
  }

  static Future<String?> getItem(String key) async{
    var res = await _secureStorage.read(key: key);
    return res;

  }

  static Future deleteItem(String key) {
    return _secureStorage.delete(key: key);
  }

}