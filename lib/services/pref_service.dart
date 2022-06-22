import 'package:riderhub/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(Constants.keyToken) ?? '';
  }

  Future setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.keyToken, token);
  }

  Future<String> getDeviceToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(Constants.keyDeviceToken) ?? '';
  }

  Future setDeviceToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.keyDeviceToken, token);
  }

  Future<String> getLanguage() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(Constants.keyLanguage) ?? 'en';
  }

  Future setLanguage(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.keyLanguage, token);
  }
}
