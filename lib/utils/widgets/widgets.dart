import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';

const lightBoxDec = BoxDecoration(
    gradient: LinearGradient(
  colors: [
    Color.fromARGB(255, 72, 170, 251),
    Color.fromARGB(255, 215, 234, 255),
    Color.fromARGB(255, 122, 163, 234),
  ],
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  tileMode: TileMode.clamp,
));

final darkBoxDec = BoxDecoration(
    gradient: LinearGradient(
  colors: [bluegrey, bluegrey2, bluegrey],
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  tileMode: TileMode.clamp,
));
