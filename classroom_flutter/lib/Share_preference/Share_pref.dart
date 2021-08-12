import 'package:classroom_flutter/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String IS_LOGGED_IN = 'is-logged-in';
  static const String LOGGED_IN_USER_TOKEN = 'logged-in-user-token';
  static const String LOGGED_IN_USER_USERNAME = 'logged-in-user-username';
  static const String LOGGED_IN_USER_EMAIL = 'logged-in-user-email';
  static const String LOGGED_IN_USER_STATUS = 'logged-in-user-status';
  static const String LOGGED_IN_USER_ID = 'logged-in-user-id';
  static const String LOGGED_IN_USER_OBJ_ID = 'logged-in-user-obj-id';
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> loadPref() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  static void setString(String key, String value) {
    _prefs?.setString(key, value);
  }

  static String? getString(String key, {String? def}) {
    String? val;
    val = _prefs?.getString(key);
    if (val == null) {
      val = def;
    }
    return val;
  }

  static void setBool(String key, bool value) {
    _prefs!.setBool(key, value);
  }

  static void setInt(String key, int value) {
    _prefs!.setInt(key, value);
  }

  static int? getInt(String key, {int? def}) {
    int? val;
    val = _prefs?.getInt(key);
    if (val == null) {
      val = def;
    }
    return val;
  }

  static bool? getBool(String key, {bool? def}) {
    bool? val;
    val = _prefs?.getBool(key);
    if (val == null) {
      val = def;
    }
    return val;
  }

  static void setLoggedInUser(LoginDataModel user) {
    _prefs?.setString(LOGGED_IN_USER_TOKEN, user.token!);
    _prefs?.setInt(LOGGED_IN_USER_ID, user.userId!);
    _prefs?.setInt(LOGGED_IN_USER_OBJ_ID, user.id!);
    _prefs?.setString(LOGGED_IN_USER_USERNAME, user.username!);
    _prefs?.setString(LOGGED_IN_USER_EMAIL, user.email!);
    _prefs?.setBool(LOGGED_IN_USER_STATUS, user.isStaff!);
    _prefs?.setBool(IS_LOGGED_IN, true);
  }

  static LoginDataModel getLoggedInUserDetails() {
    String? token = _prefs?.getString(LOGGED_IN_USER_TOKEN);
    int? userId = _prefs?.getInt(LOGGED_IN_USER_ID);
    int? id = _prefs?.getInt(LOGGED_IN_USER_OBJ_ID);
    String? username = _prefs?.getString(LOGGED_IN_USER_USERNAME);
    String? email = _prefs?.getString(LOGGED_IN_USER_EMAIL);
    bool? isStaff = _prefs?.getBool(LOGGED_IN_USER_STATUS);
    // Prefs.setBool(Prefs.IS_LOGGED_IN, true);

    return LoginDataModel(
      email: email,
      id: id,
      isStaff: isStaff,
      token: token,
      userId: userId,
      username: username,
    );
  }

  static bool? isLoggedIn() {
    return _prefs?.getBool(IS_LOGGED_IN);
  }

  static void clearPref() {
    _prefs?.clear();
  }
}
