import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

class SharedPrefs {
  void saveToken(String token) {
    final sharedPrefs = getIt<SharedPreferences>();
    sharedPrefs.setString("auth_token", token);
  }

  bool removeToken() {
    final sharedPrefs = getIt<SharedPreferences>();
    sharedPrefs.clear();
    return true;
  }

  String? getToken() {
    final sharedPreferences = getIt<SharedPreferences>();
    return sharedPreferences.getString("auth_token");
  }

  void saveSomeString(String nameOfString, String value) {
    final sharedPrefs = getIt<SharedPreferences>();
    sharedPrefs.setString(nameOfString, value);
  }

  String? getSomeString(String nameOfString) {
    final sharedPreferences = getIt<SharedPreferences>();
    return sharedPreferences.getString(nameOfString);
  }
}
