import 'dart:async';

import 'package:flutter/material.dart';


class ThemeProvider with ChangeNotifier {


  ThemeProvider(){
    // changeThemeByTime();
  }
  bool _isThemeDark = false;
  bool isloading = false;

  get themeMode => _isThemeDark;


  // ThemeProvider(){
  //   print("theme costructor called");
  //   changeThemeByTime();
  // }

  toggletheme(bool togglevalue) {
    _isThemeDark = togglevalue;
    notifyListeners();
  }



  //   void changeThemeByTime() {
  //   final currentHour = int.parse(DateFormat.H().format(DateTime.now()));
  //   final currentTime = DateTime.now();
  //   final currentMinute = currentTime.minute;


  //   if (currentHour >= 12&& currentMinute >= 45
  //   // ||
  //   //  currentHour < 6
  //    ) {
  //     toggletheme(true); // Set dark theme from 6 PM to 5:59 AM
  //   } else {
  //     toggletheme(false); // Set light theme from 6 AM to 5:59 PM
  //   }
  //   notifyListeners();
  // }

  void changeThemeByTime() {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;
    final currentMinute = currentTime.minute;

    if (currentHour == 12 && currentMinute >= 53) {
      toggletheme(true); // Set dark theme when it's 12:15 or later
    } else {
      toggletheme(false); // Set light theme at other times
    }
  });
  notifyListeners();
}
}
