// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class UiDemo extends StatelessWidget {
//   const UiDemo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       extendBodyBehindAppBar: true,
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//           height: screenSize.height,
//           width: screenSize.width,
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 225, 235, 243),
//               Color.fromARGB(255, 224, 239, 241),
//               Color.fromARGB(255, 165, 188, 229),
//             ],
//             begin: Alignment.bottomRight,
//             end: Alignment.topLeft,
//             tileMode: TileMode.clamp,
//           )),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   SizedBox(
//                     width: screenSize.width * 0.04,
//                   ),
//                   // CircleAvatar(
//                   //   backgroundColor: Colors.blue,
//                   //   radius: 35,
//                   // ),
//                   SizedBox(
//                     height: screenSize.height * 0.13,
//                   ),
//                 ],
//               ),
//               Container(
//                 width: screenSize.width * 0.85,
//                 height: screenSize.height * 0.25,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(35),
//                     gradient: const LinearGradient(
//                       colors: [
//                         Color.fromARGB(255, 31, 146, 223),
//                         Color.fromARGB(255, 172, 228, 232)
//                       ],
//                       begin: Alignment.centerRight,
//                       end: Alignment.centerLeft,
//                       tileMode: TileMode.clamp,
//                     )),
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       right: screenSize.width * 0.09,
//                       top: -screenSize.height * 0.01,
//                       child: Text(
//                         "00",
//                         style: GoogleFonts.poppins(
//                             fontSize: 90,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white),
//                       ),
//                     ),
//                     Positioned(
//                       left: screenSize.width * 0.09,
//                       top: -screenSize.height * -0.15,
//                       child: Text(
//                         "data",
//                         style: GoogleFonts.poppins(
//                             fontSize: 27, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     Positioned(
//                       left: screenSize.width * 0.092,
//                       top: -screenSize.height * -0.19,
//                       child: Text("data",
//                           style: GoogleFonts.poppins(
//                               fontSize: 25, fontWeight: FontWeight.w600)),
//                     ),
//                     Positioned(
//                       left: screenSize.width * 0.09,
//                       top: -screenSize.height * 0.055,
//                       child: SizedBox(
//                           height: screenSize.height * 0.25,
//                           width: screenSize.width * 0.35,
//                           child: Image.asset("assets/images/sun.png")),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: screenSize.height * 0.035,
//               ),
//               Container(
//                 height: screenSize.height * 0.3,
//                 width: screenSize.width * 0.85,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(35),
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: screenSize.height * 0.02,
//                     ),
//                     // Row(
//                     //   children: [
//                     //     SizedBox(width: screenSize.width*0.06,),
//                     //     Text("data",style: GoogleFonts.poppins(
//                     //         fontSize: 27, fontWeight: FontWeight.w600),
//                     //   )
//                     //   ],
//                     // ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         weatherDetails(
//                             context: context,
//                             weatherlogo: "windlogo",
//                             description: "wind",
//                             modelvalue: "3"),
//                         SizedBox(
//                           width: screenSize.width * 0.06,
//                         ),
//                         weatherDetails(
//                             context: context,
//                             weatherlogo: "humiditylogo",
//                             description: "humidity",
//                             modelvalue: "3"),
//                         SizedBox(
//                           width: screenSize.width * 0.06,
//                         ),
//                         weatherDetails(
//                             context: context,
//                             weatherlogo: "pressurelogo",
//                             description: "pressure",
//                             modelvalue: "3")
//                       ],
//                     ),
//                     SizedBox(
//                       height: screenSize.height * 0.02,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         weatherDetails(
//                             context: context,
//                             weatherlogo: "sunlogo",
//                             description: "max temp",
//                             modelvalue: "3"),
//                         SizedBox(
//                           width: screenSize.width * 0.06,
//                         ),
//                         weatherDetails(
//                             context: context,
//                             weatherlogo: "temperaturelogo",
//                             description: "feelslike",
//                             modelvalue: "3"),
//                         SizedBox(
//                           width: screenSize.width * 0.06,
//                         ),
//                         weatherDetails(
//                             context: context,
//                             weatherlogo: "visibility",
//                             description: "visibility",
//                             modelvalue: "3")
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: screenSize.height * 0.03,
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(
//                       width: screenSize.width * 0.025,
//                     ),
//                     Container(
//                       height: screenSize.height * 0.25,
//                       width: screenSize.width * 0.23,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 31, 146, 223),
//                             Color.fromARGB(255, 172, 228, 232)
//                           ],
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                           tileMode: TileMode.clamp,
//                         ),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                     ),
//                     SizedBox(
//                       width: screenSize.width * 0.025,
//                     ),
//                     Container(
//                       height: screenSize.height * 0.25,
//                       width: screenSize.width * 0.23,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 31, 146, 223),
//                             Color.fromARGB(255, 172, 228, 232)
//                           ],
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                           tileMode: TileMode.clamp,
//                         ),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                     ),
//                     SizedBox(
//                       width: screenSize.width * 0.025,
//                     ),
//                     Container(
//                       height: screenSize.height * 0.25,
//                       width: screenSize.width * 0.23,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 31, 146, 223),
//                             Color.fromARGB(255, 172, 228, 232)
//                           ],
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                           tileMode: TileMode.clamp,
//                         ),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                     ),
//                     SizedBox(
//                       width: screenSize.width * 0.025,
//                     ),
//                     Container(
//                       height: screenSize.height * 0.25,
//                       width: screenSize.width * 0.23,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 31, 146, 223),
//                             Color.fromARGB(255, 172, 228, 232)
//                           ],
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                           tileMode: TileMode.clamp,
//                         ),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                     ),
//                     SizedBox(
//                       width: screenSize.width * 0.025,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Container weatherDetails(
//     {required BuildContext context,
//     required String weatherlogo,
//     required String description,
//     required String modelvalue}) {
//   return Container(
//     height: MediaQuery.of(context).size.height * 0.12,
//     width: MediaQuery.of(context).size.width * 0.2,
//     // height: 100,
//     // width: 80,
//     decoration: BoxDecoration(color: Color.fromARGB(0, 255, 0, 0)),
//     child: Column(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.008,
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.055,
//           width: MediaQuery.of(context).size.width * 0.2,
//           child: Image.asset(
//             "assets/images/$weatherlogo.png",
//             width: MediaQuery.of(context).size.width * 0.2,
//             height:MediaQuery.of(context).size.height * 0.05 ,
//           ),
//         ),
//         Text(
//           description,
//           style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),
//         ),
//         Text(
//           modelvalue,
//           style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
//         )
//       ],
//     ),
//   );
// }
