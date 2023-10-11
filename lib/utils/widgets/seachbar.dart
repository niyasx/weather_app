import 'package:flutter/material.dart';
// import 'package:weather_app/constants/constants.dart';

// class Searchpage extends StatefulWidget {
//   const Searchpage({super.key});

//   @override
//   State<Searchpage> createState() => _SearchpageState();
// }

// class _SearchpageState extends State<Searchpage> {
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: searchpagecontroller,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       onSubmitted: (value) {
//         setState(() {
//           currentlocation = searchpagecontroller.text;
//         });

//         // Navigator.pushReplacement(
//         //     context, MaterialPageRoute(builder: (context) => HomePage()));
//         dispose();
//       },
//     );
//   }
// }

Widget getClimateImage(String discription) {
  if (discription == 'haze') {
    return Image.asset("assets/images/Clear Cloud.png");
  } else if (discription == 'overcast clouds') {
    return Image.asset("assets/images/Cloudwithsun.png");
  } else if (discription == 'clear sky') {
    return Image.asset("assets/images/Clear Cloud.png");
  } else if (discription == 'light rain') {
    return Image.asset("assets/images/Lighting.png");
  } else if (discription == 'mist') {
    return Image.asset("assets/images/mist.png");
  } else if (discription == 'broken clouds') {
    return Image.asset("assets/images/Cloudwithsun.png");
  } else if (discription == 'light intensity drizzle') {
    return Image.asset("assets/images/Raining.png");
  } else if (discription == 'drizzle') {
    return Image.asset("assets/images/mist.png");
  } else {
    return Image.asset("assets/images/sun.png");
  }
}
