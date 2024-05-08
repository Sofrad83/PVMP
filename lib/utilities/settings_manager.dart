// Packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  // ----- mail --------------------------------------------------------------
  static final String _kMail = "mail";

  static Future<String?> getMail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(_kMail) as String?;
  }

  static Future<bool> setMail(String mail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kMail, mail);
  }

  static Future<bool> removeMail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(_kMail);
  }

  // ----- mail --------------------------------------------------------------
  static final String _kMdp = "mdp";

  static Future<String?> getMdp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(_kMdp) as String?;
  }

  static Future<bool> setMdp(String mdp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kMdp, mdp);
  }

  static Future<bool> removeMdp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(_kMdp);
  }
}
