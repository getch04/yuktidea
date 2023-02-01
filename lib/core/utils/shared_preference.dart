import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? prefsInstance;
  static Future<SharedPreferences> get _instance async =>
      prefsInstance ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefsInstance = await _instance;
    return prefsInstance!;
  }

  static String getString(
    String key,
  ) {
    return prefsInstance!.getString(key) ?? '';
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }
}
