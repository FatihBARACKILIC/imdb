import 'package:shared_preferences/shared_preferences.dart';

/// showOnboardScreen
/// selectedLanguage
/// darkMode
/// id

class SharedPreferencesHelper {
  static Future getLoginRegister() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String result = sharedPreferences.getString("id") ?? "";
    return result;
  }

  static Future darkMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = sharedPreferences.getBool("darkMode") ?? true;
    return result;
  }

  static Future<bool> showOnboardScreen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = sharedPreferences.getBool("showOnboardScreen") ?? true;
    return result;
  }

  static Future<String> selectedLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String result = sharedPreferences.getString("selectedLanguage") ?? "en";
    return result;
  }

  static Future setSharedPreferences(String key, var value) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      switch (value.runtimeType) {
        case int:
          sharedPreferences.setInt(key, value);
          break;
        case double:
          sharedPreferences.setDouble(key, value);
          break;
        case bool:
          sharedPreferences.setBool(key, value);
          break;
        case String:
          sharedPreferences.setString(key, value);
          break;
        case List<String>:
          sharedPreferences.setStringList(key, value);
          break;
        default:
          return false;
      }
      return true;
    } on FormatException {
      return "Wrong type data";
    } catch (e) {
      return e;
    }
  }

  static Future<bool> removeSharedPreferences(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.remove(key);
    return result;
  }
}
