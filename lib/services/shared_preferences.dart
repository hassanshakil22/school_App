import "package:school_app/app/pref_constants.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:intl/intl.dart';

class UserPrefs {
  static SharedPreferences? _pref;
  static Future init() async => _pref = await SharedPreferences.getInstance();

  /////////////////////////////////[ User ]///////////////////////////////////////////////////////////////////////

 static Future<void> setUserSessionExpiry(DateTime expiryDate) async {
  await _pref?.setString(
    PrefKeys.userSessionKey, 
    expiryDate.toIso8601String()
  );
}
static Future<bool> isSessionValid() async {
  final token = await getToken();
  if (token.isEmpty) return false;
  
  final expiryString = _pref?.getString(PrefKeys.userSessionKey);
  if (expiryString == null || expiryString.isEmpty) return false;
  
  try {
    final expiryDate = DateTime.parse(expiryString);
    return expiryDate.isAfter(DateTime.now());
  } catch (e) {
    return false;
  }
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
