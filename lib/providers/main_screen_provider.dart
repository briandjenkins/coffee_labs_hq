import 'package:flutter/material.dart';

import '../enums/screens.dart';

class MainScreenProvider extends ChangeNotifier {
  // Bottom menu's
  Enum _screen = Screens.Cupping;

  int get getScreenNavigationIndex {
    return (_screen.index > 3) ? 3 : _screen.index;
  }

  Enum get getNavigationScreen {
    return _screen;
  }

  void set setNavigationScreen(Enum Screen) {
    _screen = Screen;
    notifyListeners();
  }

  void refreshScreen() {
    notifyListeners();
  }
}