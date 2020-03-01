import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setBoolPreference(key, value) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    return true;
  } catch (error) {
    throw error;
  }
}

Future<bool> getBoolPreference(key) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key);
    return value;
  } catch (error) {
    print(error);
    throw error;
  }
}
