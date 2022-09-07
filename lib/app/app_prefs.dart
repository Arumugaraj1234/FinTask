import 'package:fin_task/app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(AppConstants.prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(AppConstants.prefsKeyIsUserLoggedIn) ??
        false;
  }
}
