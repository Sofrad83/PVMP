// Packages
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  // ----- traderId --------------------------------------------------------------
  static final String _kTraderId = "traderId";

  static Future<dynamic> getTraderId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kTraderId) ?? false;
  }

  static Future<bool> setTraderId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kTraderId, value);
  }

  static Future<bool> removeTraderId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(_kTraderId);
  }

  // -----  --------------------------------------------------------------

  static final String _kDeviceType = '_kDeviceType';

  static Future<dynamic> getDeviceType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_kDeviceType) ?? false;
  }

  static Future<bool> setDeviceType(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(_kDeviceType, value);
  }

  static Future<bool> removeDeviceType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(_kDeviceType);
  }

  // -----  --------------------------------------------------------------

  static final String _kAdminMail = '_kAdminMail';

  static Future<dynamic> getAdminMail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kAdminMail) ?? false;
  }

  static Future<bool> setAdminMail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kAdminMail, value);
  }

  static Future<bool> removeAdminMail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(_kAdminMail);
  }

  // -----  --------------------------------------------------------------

  static final String _kIsAdmin = '_kIsAdmin';

  static Future<dynamic> getIsAdmin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kIsAdmin) ?? false;
  }

  static Future<bool> setIsAdmin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kIsAdmin, value);
  }

  static Future<bool> removeIsAdmin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(_kIsAdmin);
  }
}
