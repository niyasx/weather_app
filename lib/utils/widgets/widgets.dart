import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';

const lightBoxDec = BoxDecoration(
    gradient: LinearGradient(
  colors: [
    Color.fromARGB(255, 225, 235, 243),
    Color.fromARGB(255, 224, 239, 241),
    Color.fromARGB(255, 165, 188, 229),
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
