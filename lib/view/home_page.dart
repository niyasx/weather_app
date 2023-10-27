// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/services/api_services.dart';
import 'package:weather_app/utils/widgets/climateimage.dart';
import 'package:weather_app/utils/widgets/hourly_weather.dart';
import 'package:weather_app/utils/widgets/widgets.dart';
import 'package:weather_app/viewmodel/provider/theme_provider.dart';
import 'package:weather_app/viewmodel/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  bool isloading = false;
  bool isthemedark = true;

  String getDate(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat("EEEE").format(time);
    return x;
  }



  @override
  Widget build(BuildContext context) {
    print('homepage builted');
    var pro = Provider.of<LocationProvider>(context);
    var themepro = Provider.of<ThemeProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    final currentDate = DateFormat('EEEE, MMM d').format(DateTime.now());


  Future<void> _onRefresh() async {
    await pro.refreshWeatherData();
   
  }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: screenSize.height * 0.08,
          elevation: 0,
          centerTitle: true,
          title: SizedBox(
            height: screenSize.height * 0.068,
            width: screenSize.width * 0.45,
            child: TextField(
                controller: searchpagecontroller,
                onSubmitted: (value) async {
                  setState(
                    () {
                      isloading = true;
                    },
                  );

                  currentlocation = searchpagecontroller.text;

                  pro.weatherModel =
                      await apiService.fetchdatafromApi(currentlocation);

                  await pro.getLatandLonFromAddress(currentlocation!);

                  pro.forecastweather = await apiService.fetchforcastfromlatlon(
                      latitude: pro.latitude, longitude: pro.longitude);

                  setState(
                    () {
                      isloading = false;
                      searchpagecontroller.clear();
                    },
                  );
                },
                decoration: InputDecoration(
                    prefixIconColor: Colors.deepPurple.shade400,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w500))),
          ),
          actions: [
            Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.015,
                ),
                SizedBox(
                  width: screenSize.width * 0.15,
                  child: FlutterSwitch(
                      borderRadius: 18,
                      duration: const Duration(microseconds: 0),
                      padding: 2,
                      toggleSize: 30,
                      height: 32,
                      value: themepro.themeMode,
                      onToggle: (mode) {
                        themepro.toggletheme(mode);
                      },
                      activeIcon: Image.asset("assets/images/suntogle.png"),
                      inactiveIcon: Image.asset("assets/images/moon.png"),
                      activeColor: greydark,
                      inactiveColor: greylight,
                      toggleColor: themepro.themeMode
                          ? Colors.white
                          : const Color.fromARGB(255, 191, 196, 199)),
                ),
                SizedBox(
                  height: screenSize.height * 0.002,
                ),
                themepro.themeMode
                    ? Text(
                        "light mode",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )
                    : Text(
                        "dark mode",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: bluegrey),
                      )
              ],
            ),
            SizedBox(
              width: screenSize.width * 0.02,
            )
          ],
        ),
        body: isloading
            ? Center(
                child: Image.asset(
                  'assets/images/giphy.gif',
                  width: 150,
                  height: 150,
                ),
              )
            : Consumer<ThemeProvider>(
                builder: (BuildContext context, themeprovider, Widget? child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: Container(
                        height: screenSize.height,
                        width: screenSize.width,
                        decoration:
                            themeprovider.themeMode ? darkBoxDec : lightBoxDec,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: screenSize.height * 0.03,
                              ),
                              Container(
                                width: screenSize.width * 0.85,
                                height: screenSize.height * 0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    gradient: themeprovider.themeMode
                                        ? LinearGradient(
                                            colors: [greydark, greylight],
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            tileMode: TileMode.clamp,
                                          )
                                        : const LinearGradient(
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
                                        "${pro.weatherModel?.temperature?.round() ?? 0}°",
                                        style: GoogleFonts.poppins(
                                            fontSize: 80,
                                            fontWeight: FontWeight.w700,
                                            color: themeprovider.themeMode
                                                ? darkdesc
                                                : Colors.black),
                                      ),
                                    ),
                                    Positioned(
                                      right: screenSize.width * 0.05,
                                      top: -screenSize.height * -0.12,
                                      child: Text(
                                        pro.weatherModel?.description ??
                                            "not available",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: themeprovider.themeMode
                                                ? darkdesc
                                                : Colors.grey.shade800),
                                      ),
                                    ),
                                    Positioned(
                                      left: screenSize.width * 0.04,
                                      top: -screenSize.height * -0.15,
                                      child: Text(
                                        pro.weatherModel?.cityName ??
                                            "city not found",
                                        style: GoogleFonts.poppins(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Positioned(
                                      left: screenSize.width * 0.04,
                                      top: -screenSize.height * -0.19,
                                      child: Text(currentDate,
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Positioned(
                                      left: screenSize.width * 0.03,
                                      top: -screenSize.height * 0.055,
                                      child: SizedBox(
                                          height: screenSize.height * 0.25,
                                          width: screenSize.width * 0.35,
                                          child: getClimateImage(
                                              "${pro.weatherModel?.description}")),
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
                                  color: themeprovider.themeMode
                                      ? ash
                                      : const Color.fromARGB(255, 136, 194, 246),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        weatherDetails(
                                            context: context,
                                            weatherlogo: "windicon",
                                            description: "wind",
                                            modelvalue:
                                                "${pro.weatherModel?.speed ?? 0}km/h"),
                                        SizedBox(
                                          width: screenSize.width * 0.06,
                                        ),
                                        weatherDetails(
                                            context: context,
                                            weatherlogo: "humidity icon",
                                            description: "humidity",
                                            modelvalue:
                                                "${pro.weatherModel?.humidity ?? 0}%"),
                                        SizedBox(
                                          width: screenSize.width * 0.06,
                                        ),
                                        weatherDetails(
                                            context: context,
                                            weatherlogo: "pressureicon",
                                            description: "pressure",
                                            modelvalue:
                                                "${pro.weatherModel?.pressure ?? 0} hPa")
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        weatherDetails(
                                            context: context,
                                            weatherlogo: "sunicon",
                                            description: "maxtemp",
                                            modelvalue:
                                                "${pro.weatherModel?.tempMax ?? 0}°C"),
                                        SizedBox(
                                          width: screenSize.width * 0.06,
                                        ),
                                        weatherDetails(
                                            context: context,
                                            weatherlogo: "thermometericon",
                                            description: "feelslike",
                                            modelvalue:
                                                "${pro.weatherModel?.feelsLike ?? 0}°C"),
                                        SizedBox(
                                          width: screenSize.width * 0.06,
                                        ),
                                        weatherDetails(
                                            context: context,
                                            weatherlogo: "visibilityicon",
                                            description: "visibility",
                                            modelvalue:
                                                "${pro.weatherModel?.visibility?.round() ?? 0}km")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                                
                              SizedBox(
                                height: screenSize.height * 0.06,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenSize.width * 0.04,
                                    ),
                                    Text(
                                      "Today",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                                
                              //hourly data
                                
                              SizedBox(
                                height: screenSize.height * 0.22,
                                width: screenSize.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 12,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: screenSize.height * 0.25,
                                      width: screenSize.width * 0.23,
                                      decoration: BoxDecoration(
                                        gradient: themepro.themeMode
                                            ? LinearGradient(
                                                colors: [bluegrey, greylight],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                tileMode: TileMode.clamp,
                                              )
                                            : const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 88, 115, 225),
                                                  Color.fromARGB(
                                                      255, 117, 176, 227)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                tileMode: TileMode.clamp,
                                              ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: HourlyData(
                                        temperature: pro
                                            .forecastweather!.hourly![index].temp!
                                            .toString(),
                                        timestamp: pro
                                            .forecastweather!.hourly![index].dt!,
                                        weathericon: pro
                                            .forecastweather!
                                            .hourly![index]
                                            .weather![0]
                                            .description!,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // SizedBox(
                              //   height: screenSize.height * 0.025,
                              // ),
                                
                              SizedBox(
                                height: screenSize.height * 0.06,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenSize.width * 0.04,
                                    ),
                                    Text(
                                      "Next Days",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                                
                              //daily data
                                
                              SizedBox(
                                height: screenSize.height * 0.7,
                                width: screenSize.width * 0.95,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: pro.forecastweather!.daily?.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height: screenSize.height * 0.07,
                                      width: screenSize.width * 0.5,
                                      decoration: BoxDecoration(
                                        gradient: themepro.themeMode
                                            ? LinearGradient(
                                                colors: [bluegrey, greylight],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                tileMode: TileMode.clamp,
                                              )
                                            : const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 107, 107, 236),
                                                  Color.fromARGB(
                                                      255, 153, 186, 232)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                tileMode: TileMode.clamp,
                                              ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            getDate(pro.forecastweather!
                                                .daily![index].dt),
                                            // pro.forecastweather!.daily![index]
                                            //     .weather![0].description!,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.1,
                                            child: getClimateImage(pro
                                                .forecastweather!
                                                .daily![index]
                                                .weather![0]
                                                .description!),
                                          ),
                                          Text(
                                            "${pro.forecastweather!.daily![index].temp!.min!.round().toString()}°C/${pro.forecastweather!.daily![index].temp!.max!.round().toString()}°C",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.33,
                                width: screenSize.width * 0.8,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          right: 20,
                                          bottom: 20),
                                      child: Text(
                                        "Comfort Level",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: themepro.themeMode
                                                ? Colors.white70
                                                : Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.25,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: SleekCircularSlider(
                                              appearance:
                                                  CircularSliderAppearance(
                                                      animationEnabled: true,
                                                      size: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.18,
                                                      infoProperties: InfoProperties(
                                                          mainLabelStyle:
                                                              GoogleFonts.poppins(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: themepro
                                                                          .themeMode
                                                                      ? Colors
                                                                          .white70
                                                                      : Colors
                                                                          .black),
                                                          bottomLabelText:
                                                              "Humidity",
                                                          bottomLabelStyle:
                                                              GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: themepro
                                                                          .themeMode
                                                                      ? Colors
                                                                          .white70
                                                                      : Colors.black)),
                                                      customWidths: CustomSliderWidths(
                                                        trackWidth: 14,
                                                        handlerSize: 5,
                                                      ),
                                                      customColors: CustomSliderColors(
                                                        progressBarColors: [
                                                          Colors.blueGrey,
                                                          Colors.lightBlue
                                                        ],
                                                        trackColor: Colors.grey,
                                                        // hideShadow: true
                                                      )),
                                              min: 0,
                                              max: 100,
                                              initialValue: pro.forecastweather!
                                                  .current!.humidity!
                                                  .toDouble(),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Feels like ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: themepro.themeMode
                                                            ? Colors.white70
                                                            : Colors.black)),
                                                TextSpan(
                                                    text: pro.forecastweather!
                                                        .current!.feelsLike!
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: themepro.themeMode
                                                            ? Colors.white70
                                                            : Colors.black))
                                              ])),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                              ),
                                              RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Uv index ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: themepro.themeMode
                                                            ? Colors.white70
                                                            : Colors.black)),
                                                TextSpan(
                                                    text: pro.forecastweather!
                                                        .current!.uvi!
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: themepro.themeMode
                                                            ? Colors.white70
                                                            : Colors.black))
                                              ]))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
        

        /// Likes

        );
  }
}

Container weatherDetails(
    {required BuildContext context,
    required String weatherlogo,
    required String description,
    required String modelvalue}) {
  var thememode = Provider.of<ThemeProvider>(context).themeMode;
  return Container(
    height: MediaQuery.of(context).size.height * 0.13,
    width: MediaQuery.of(context).size.width * 0.2,
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
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          description,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: thememode ? conditionfont : Colors.grey.shade700),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          modelvalue,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}

// SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       SizedBox(
//         width: screenSize.width * 0.025,
//       ),
//       Container(
//         height: screenSize.height * 0.25,
//         width: screenSize.width * 0.23,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color.fromARGB(255, 31, 146, 223),
//               Color.fromARGB(255, 172, 228, 232)
//             ],
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             tileMode: TileMode.clamp,
//           ),
//           borderRadius: BorderRadius.circular(50),
//         ),
//       ),
//       SizedBox(
//         width: screenSize.width * 0.025,
//       ),
//       Container(
//         height: screenSize.height * 0.25,
//         width: screenSize.width * 0.23,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color.fromARGB(255, 31, 146, 223),
//               Color.fromARGB(255, 172, 228, 232)
//             ],
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             tileMode: TileMode.clamp,
//           ),
//           borderRadius: BorderRadius.circular(50),
//         ),
//       ),
//       SizedBox(
//         width: screenSize.width * 0.025,
//       ),
//       Container(
//         height: screenSize.height * 0.25,
//         width: screenSize.width * 0.23,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color.fromARGB(255, 31, 146, 223),
//               Color.fromARGB(255, 172, 228, 232)
//             ],
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             tileMode: TileMode.clamp,
//           ),
//           borderRadius: BorderRadius.circular(50),
//         ),
//       ),
//       SizedBox(
//         width: screenSize.width * 0.025,
//       ),
//       Container(
//         height: screenSize.height * 0.25,
//         width: screenSize.width * 0.23,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color.fromARGB(255, 31, 146, 223),
//               Color.fromARGB(255, 172, 228, 232)
//             ],
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             tileMode: TileMode.clamp,
//           ),
//           borderRadius: BorderRadius.circular(50),
//         ),
//       ),
//       SizedBox(
//         width: screenSize.width * 0.025,
//       ),
//     ],
//   ),
// )
