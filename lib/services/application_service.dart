import 'dart:async';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/login_status.dart';


class ApplicationService {

  // Security
  String _jwt = "";
  LoginStatus _loginStatue = LoginStatus.loggedOut;
  DateTime? _lastPriceRereshUpdateTime;
  DateTime? _lastCustomerDataRereshUpdateTime;
  SharedPreferences? _prefs;

  static final ApplicationService _instance = ApplicationService._();

  ApplicationService._() {
    init();
  }

  void init() {
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
    });
  }

  DateTime? get getLastPriceRefreshUpdateTime {
    return _lastPriceRereshUpdateTime;
  }

  void set setLastPriceRefreshUpdateTime(DateTime dateTime) {
    _lastPriceRereshUpdateTime = dateTime;
  }

  DateTime? get getLastCustomerDataRefreshUpdateTime {
    return _lastCustomerDataRereshUpdateTime;
  }

  void set setLastCustomerDataRefreshUpdateTime(DateTime dateTime) {
    _lastCustomerDataRereshUpdateTime = dateTime;
  }

  LoginStatus get getLoginStatus {
    return _loginStatue;
  }

  void set setLoginStatus(LoginStatus loginStatus) {
    _loginStatue = loginStatus;
  }

  static ApplicationService get instance => _instance;


  void set setJwt(String firebaseMessagingToken) {
    _jwt = firebaseMessagingToken;
  }

  String get getJwt {
    return _jwt;
  }

  SharedPreferences? getPrefs() {
    return _prefs;
  }

}
