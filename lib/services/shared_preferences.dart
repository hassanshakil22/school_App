import "package:school_app/app/pref_constants.dart";
import "package:shared_preferences/shared_preferences.dart";

class UserPrefs {
  static SharedPreferences? _pref;
  static Future init() async => _pref = await SharedPreferences.getInstance();

  /////////////////////////////////[ User ]///////////////////////////////////////////////////////////////////////

  static Future setUserSession(bool value) async {
    try {
      await _pref
          ?.setBool(PrefKeys.userSessionKey, value)
          .catchError((error) => throw error);
      print("user session cached successfully");
    } catch (e) {
      return e;
    }
  }

  static Future<bool?> getUserSession() async {
    bool? value = _pref?.getBool(PrefKeys.userSessionKey);
    return value;
  }
  static Future setToken(String value) async {
    try {
      await _pref
          ?.setString(PrefKeys.token, value)
          .catchError((error) => throw error);
    } catch (e) {
      return e;
    }
  }

  static Future<String> getToken() async {
    String? value = _pref?.getString(PrefKeys.token);
    return value ?? "";
  }

  static Future<void> delToken() async {
    await _pref?.remove(PrefKeys.token);
  }


  static Future setBool(String key, bool value) async {
    try {
      await _pref?.setBool(key, value).catchError((error) => throw error);
    } catch (e) {
      return e;
    }
  }

  static Future<bool?> getBool(String key) async {
    bool? value = _pref?.getBool(key);
    return value;
  }
}
