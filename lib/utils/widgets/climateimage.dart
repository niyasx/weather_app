import 'package:flutter/material.dart';

Widget getClimateImage(String discription) {
  if (discription == 'haze') {
    return Image.asset("assets/images/haze.png");
  } else if (discription == 'overcast clouds') {
    return Image.asset("assets/images/Cloudwithsun.png");
  } else if (discription == 'clear sky') {
    return Image.asset("assets/images/clear-sky.png");
  } else if (discription == 'light rain') {
    return Image.asset("assets/images/light-rain.png");
  } else if (discription == 'mist') {
    return Image.asset("assets/images/mist.png");
  } else if (discription == 'broken clouds') {
    return Image.asset("assets/images/overcast-clouds.png");
  } else if (discription == 'light intensity drizzle') {
    return Image.asset("assets/images/drizzle.png");
  } else if (discription == 'drizzle') {
    return Image.asset("assets/images/drizzle.png");
  } else if (discription == 'few clouds') {
    return Image.asset("assets/images/few-clouds.png");
  } else if (discription == 'rain') {
    return Image.asset("assets/images/heavy-rain.png");
  } else if (discription == 'thunderstorm') {
    return Image.asset("assets/images/heavy-rain.png");
  } else if (discription == 'light snow') {
    return Image.asset("assets/images/mist.png");
  } else if (discription == 'scattered clouds') {
    return Image.asset("assets/images/overcast-clouds.png");
  } else if (discription == 'smoke') {
    return Image.asset("assets/images/smoke.png");
  }  else if (discription == 'moderate rain') {
    return Image.asset("assets/images/heavy-rain.png");
  } else if (discription == 'heavy intensity rain') {
    return Image.asset("assets/images/heavy-rain.png");
  } else {
    return Image.asset("assets/images/sun.png");
  }
}
