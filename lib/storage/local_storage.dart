import 'package:shared_preferences/shared_preferences.dart';
class LocalStorage {

  static  late SharedPreferences _sharedPreferences ;
  static final LocalStorage instance = LocalStorage._internal();

  LocalStorage._internal() {
    intializeSharedPreferences();
  }

  factory LocalStorage(){
    return instance;
  }

  static Future intializeSharedPreferences() async{
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setItem (String key, String value){
    return _sharedPreferences.setString(key, value);
  }

  static String? getItem (String key){
    return _sharedPreferences.getString(key);
  }
  static Future<bool> deleteItem (String key){
    return _sharedPreferences.clear();
  }

}