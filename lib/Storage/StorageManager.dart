import 'package:shared_preferences/shared_preferences.dart';

class StorageManager{
  static late SharedPreferences preferences;

  static Future<void> init() async{
    preferences = await SharedPreferences.getInstance();
  }

  static String getString(String key){
    return preferences.getString(key) ?? "";
  }

  static Future<void> setString(String key, String value) async {
    await preferences.setString(key, value);
  }

  static bool isEmpty(String key){
    return getString(key) == "";
  }
}