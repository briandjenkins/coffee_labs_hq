import 'package:flutter/material.dart';
import '../services/application_service.dart';


class LoginScreenProvider extends ChangeNotifier {
  bool _isRememberMe = false;
  bool _isLoading = false;
  String _emailAddress = "";
  String _password = "";
  bool _isObscure = true;

  void set isRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }

  bool get isRememberMe {
    return _isRememberMe;
  }

  void set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }

  set setEmailAddress(String emailAddress) {
    _emailAddress = emailAddress;
  }

  String get getEmailAddress {
    return _emailAddress;
  }

  set setPassword(String password) {
    _password = password;
  }

  String get getPassword {
    return _password;
  }

  bool get isObscure {
    return _isObscure;
  }

  void set setObscure(bool obscure) {
    _isObscure = obscure;
    notifyListeners();
  }

  void initializeWidgets() {
    _emailAddress = ApplicationService.instance.getPrefs()?.getString("emailAddress") ?? "";
    _password = ApplicationService.instance.getPrefs()?.getString("password") ?? "";
    _isRememberMe = ApplicationService.instance.getPrefs()?.getBool("isChecked") ?? false;
  }

  void updatePreferences() async {
    await ApplicationService.instance.getPrefs()?.setBool("isChecked", _isRememberMe);
    await ApplicationService.instance.getPrefs()?.setString("emailAddress", _emailAddress);
    await ApplicationService.instance.getPrefs()?.setString("password", _password);
  }

  void removePreferences() async {
    ApplicationService.instance.getPrefs()?.clear();
    _emailAddress = "";
    _password = "";
  }

}
