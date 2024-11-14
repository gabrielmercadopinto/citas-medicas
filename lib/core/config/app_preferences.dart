import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  
  static final AppPreferences _instance = AppPreferences._internal();

  
  factory AppPreferences() {
    return _instance;
  }

  // Constructor privado
  AppPreferences._internal();

  SharedPreferences? _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int get userId {
    return _prefs?.getInt('userId') ?? 0;
  }

  set userId(int value) {
    _prefs?.setInt('userId', value);
  }

  String get lastDateAppointment {
    return _prefs?.getString('lastDateAppointment') ?? '';
  }

  set lastDateAppointment(String value) {
    _prefs?.setString('lastDateAppointment', value);
  }  

  Future<void> clearPreferences() async {
    await _prefs?.clear();
  }

  bool get isInsuranceCreated {
    return _prefs?.getBool('isInsuranceCreated') ?? false;
  }

  set isInsuranceCreated(bool value) {
    _prefs?.setBool('isInsuranceCreated', value);
  }

}
