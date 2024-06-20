import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefServices {
  static Future setString({required String value, required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String> getString({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result =  prefs.getString(key) ?? '';
    return result;
  }

  static Future removekey({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
