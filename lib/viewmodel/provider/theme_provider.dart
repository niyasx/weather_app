import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isThemeDark = false;

  get themeMode => _isThemeDark;

  toggletheme(bool togglevalue) {
    _isThemeDark = togglevalue;
    notifyListeners();
  }
}
