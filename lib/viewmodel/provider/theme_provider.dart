import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThemeProvider with ChangeNotifier {
  bool _isThemeDark = false;

  get themeMode => _isThemeDark;


  // ThemeProvider(){
  //   print("theme costructor called");
  //   changeThemeByTime();
  // }

  toggletheme(bool togglevalue) {
    _isThemeDark = togglevalue;
    notifyListeners();
  }



    void changeThemeByTime() {
    final currentHour = int.parse(DateFormat.H().format(DateTime.now()));

    if (currentHour >= 10 || currentHour < 6) {
      toggletheme(true); // Set dark theme from 6 PM to 5:59 AM
    } else {
      toggletheme(false); // Set light theme from 6 AM to 5:59 PM
    }
  }
}
