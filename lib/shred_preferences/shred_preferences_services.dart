import 'package:shared_preferences/shared_preferences.dart';


class PrefServices{
  Future createCache(String username, String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("username", username);
    _preferences.setString("password", password);
  }

  Future readCache(String username) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var username = _preferences.getString("username")?? "khali";
    // _preferences.getString("password");
    return username;
  }

  Future<void> removeCache(String username, String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("username");
    _preferences.remove("password");
  }


}