import 'package:dark_light_button/dark_light_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/services/api_services.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/utils/widgets/seachbar.dart';
import 'package:weather_app/view/ui.dart';
import 'package:weather_app/viewmodel/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  final locationwether;
  HomePage({super.key, this.locationwether});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? model;

  ApiService apiService = ApiService();
  bool isloading=false;
  // Future<void> getData() async {
  //   print("CALLED GET DATA FUNCTION");
  //   await Future.delayed(const Duration(seconds: 2));
  //   model = await apiService.fetchdatafromApi(currentlocation);
  //   print("ENDED GETDATA FUNCTION");
  // }

  @override
  Widget build(BuildContext context) {
    // print(widget.locationwether);
    var pro=Provider.of<LocationProvider>(context);

    var screenSize = MediaQuery.of(context).size;
    final currentDate = DateFormat('EEEE, MMM d').format(DateTime.now());


          return Scaffold(
            // extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: TextField(
                controller:searchpagecontroller ,
                onSubmitted: (value) async {
                  setState(() {
                    isloading=true;
                  });
                  print(isloading);
                   currentlocation = searchpagecontroller.text;
          pro.model=await apiService.fetchdatafromApi(currentlocation);

                  setState(() {
         isloading=false;
         searchpagecontroller.clear();
        });
                },
              ),
            //  title: Row(mainAxisAlignment: MainAxisAlignment.center,
            //    children: [
            //      IconButton(onPressed: (){
            //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
            //         }, icon: const Icon(Icons.search),
            //       ),
            //       Text("Search city",style: GoogleFonts.poppins(fontSize: 14),)
            //    ],
            //  ),
            ),
            // resizeToAvoidBottomInset: false,
            // extendBodyBehindAppBar: true,
            body:isloading?Center(child: CircularProgressIndicator()): SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: screenSize.height,
                width: screenSize.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 225, 235, 243),
                    Color.fromARGB(255, 224, 239, 241),
                    Color.fromARGB(255, 165, 188, 229),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  tileMode: TileMode.clamp,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.04,

                          
                        ),
                       DarlightButton(onChange: (the) {
                         
                       },type: Darlights.DarlightTwo,),
                        SizedBox(
                          height: screenSize.height * 0.13,
                        ),
                      ],
                    ),
                    Container(
                      width: screenSize.width * 0.85,
                      height: screenSize.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 31, 146, 223),
                              Color.fromARGB(255, 172, 228, 232)
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            tileMode: TileMode.clamp,
                          )),
                      child: Stack(
                        children: [
                          Positioned(
                            right: screenSize.width * 0.075,
                            top: -screenSize.height * -0.01,
                            child: Text(
                              "${pro.model?.temperature?.round()}°",
                              style: GoogleFonts.poppins(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            right: screenSize.width * 0.1,
                            top: -screenSize.height * -0.12,
                            child: Text(
                              "${pro.model?.description}",
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800),
                            ),
                          ),
                          Positioned(
                            left: screenSize.width * 0.04,
                            top: -screenSize.height * -0.15,
                            child: Text(
                              "${pro.model?.cityName}",
                              style: GoogleFonts.poppins(
                                  fontSize: 26, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Positioned(
                            left: screenSize.width * 0.04,
                            top: -screenSize.height * -0.19,
                            child: Text(currentDate,
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                          Positioned(
                            left: screenSize.width * 0.03,
                            top: -screenSize.height * 0.055,
                            child: SizedBox(
                                height: screenSize.height * 0.25,
                                width: screenSize.width * 0.35,
                                child:
                                    getClimateImage("${pro.model?.description}")),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.035,
                    ),
                    Container(
                      height: screenSize.height * 0.3,
                      width: screenSize.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.02,
                          ),
                          // Row(
                          //   children: [
                          //     SizedBox(width: screenSize.width*0.06,),
                          //     Text("data",style: GoogleFonts.poppins(
                          //         fontSize: 27, fontWeight: FontWeight.w600),
                          //   )
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              weatherDetails(
                                  context: context,
                                  weatherlogo: "windlogo",
                                  description: "wind",
                                  modelvalue: "${pro.model?.speed}km/h"),
                              SizedBox(
                                width: screenSize.width * 0.06,
                              ),
                              weatherDetails(
                                  context: context,
                                  weatherlogo: "humiditylogo",
                                  description: "humidity",
                                  modelvalue: "${pro.model?.humidity}%"),
                              SizedBox(
                                width: screenSize.width * 0.06,
                              ),
                              weatherDetails(
                                  context: context,
                                  weatherlogo: "pressurelogo",
                                  description: "pressure",
                                  modelvalue: "${pro.model?.pressure} hPa")
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              weatherDetails(
                                  context: context,
                                  weatherlogo: "sunlogo",
                                  description: "maxtemp",
                                  modelvalue: "${pro.model?.tempMax}°"),
                              SizedBox(
                                width: screenSize.width * 0.06,
                              ),
                              weatherDetails(
                                  context: context,
                                  weatherlogo: "temperaturelogo",
                                  description: "feelslike",
                                  modelvalue: "${pro.model?.feelsLike}°"),
                              SizedBox(
                                width: screenSize.width * 0.06,
                              ),
                              weatherDetails(
                                  context: context,
                                  weatherlogo: "visibility",
                                  description: "visibility",
                                  modelvalue: "${pro.model?.visibility}")
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.025,
                          ),
                          Container(
                            height: screenSize.height * 0.25,
                            width: screenSize.width * 0.23,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 31, 146, 223),
                                  Color.fromARGB(255, 172, 228, 232)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                tileMode: TileMode.clamp,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.025,
                          ),
                          Container(
                            height: screenSize.height * 0.25,
                            width: screenSize.width * 0.23,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 31, 146, 223),
                                  Color.fromARGB(255, 172, 228, 232)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                tileMode: TileMode.clamp,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.025,
                          ),
                          Container(
                            height: screenSize.height * 0.25,
                            width: screenSize.width * 0.23,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 31, 146, 223),
                                  Color.fromARGB(255, 172, 228, 232)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                tileMode: TileMode.clamp,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.025,
                          ),
                          Container(
                            height: screenSize.height * 0.25,
                            width: screenSize.width * 0.23,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 31, 146, 223),
                                  Color.fromARGB(255, 172, 228, 232)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                tileMode: TileMode.clamp,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.025,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }
//     );
//   }
// }

Container weatherDetails(
    {required BuildContext context,
    required String weatherlogo,
    required String description,
    required String modelvalue}) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.12,
    width: MediaQuery.of(context).size.width * 0.2,
    // height: 100,
    // width: 80,
    decoration: const BoxDecoration(color: Color.fromARGB(0, 255, 0, 0)),
    child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.006,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.055,
          width: MediaQuery.of(context).size.width * 0.2,
          child: Image.asset(
            "assets/images/$weatherlogo.png",
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ),SizedBox(height: 2,),
        Text(
          description,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700),
        ),SizedBox(height: 4,),
        Text(
          modelvalue,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}



// return SafeArea(
          //   child: Scaffold(
          //     appBar: AppBar(
          //       leading: IconButton(onPressed: (){
          //         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          //       }, icon: Icon(Icons.search),)
          //     ),
          //     body: SizedBox(
          //       height: screenHieght,
          //       width: screenWidth,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //          SizedBox(
          //           height: 150,
          //           width: 150,
          //           child: getClimateImage("${model?.description}")),
          //           Text(
          //             "${model?.cityName}",
          //             style: const TextStyle(fontSize: 30),
          //           ),
          //           // Text(
          //           //   "${model?.description}",
          //           //   style: const TextStyle(fontSize: 30),
          //           // ),
          //           // Text(
          //           //   "${model?.clouds}",
          //           //   style: const TextStyle(fontSize: 30),
          //           // ),
          //           Text(
          //             "${model?.temperature}",
          //             style: const TextStyle(fontSize: 30),
          //           ),
          //           // Text(
          //           //   "${model?.humidity}",
          //           //   style: const TextStyle(fontSize: 30),
          //           // ),
          //           Text(
          //             "${model?.pressure}",
          //             style: const TextStyle(fontSize: 30),
          //           ),
          //           // Text(
          //           //   "${model?.tempMin}",
          //           //   style: const TextStyle(fontSize: 30),
          //           // ),
          //           // Text(
          //           //   "${model?.tempMax}",
          //           //   style: const TextStyle(fontSize: 30),
          //           // ),
          //           // Text(
          //           //   "${model?.visibility}",
          //           //   style: const TextStyle(fontSize: 30),
          //           // ),
          //           // Text(
          //           //   "${model?.speed}",
          //           //   style: const TextStyle(fontSize: 30),
          //           // ),
          //           // Text(
          //           //   "${model?.feelsLike}",
          //           //   style: const TextStyle(fontSize: 30),
          //           // ),
          //           Text(
          //             "${currentDate}",
          //             style: const TextStyle(fontSize: 30),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
          // } else {
          //   return Container();


              // return FutureBuilder(
    //   future: getData(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Stack(children: [
    //         Image.asset(
    //           'assets/images/sky.jpg',
    //           fit: BoxFit.cover,
    //           width: double.infinity,
    //           height: double.infinity,
    //         ),
    //         Center(
    //             child: Image.asset(
    //           "assets/images/giphy.gif",
    //           width: 150,
    //           height: 150,
    //         ))
    //       ]);
    //     } else {