import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static String? getString(String key) => _preferences.getString(key);
}
