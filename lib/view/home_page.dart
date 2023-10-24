// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    print('homepage builted');
    var pro = Provider.of<LocationProvider>(context);
    var themepro = Provider.of<ThemeProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    final currentDate = DateFormat('EEEE, MMM d').format(DateTime.now());

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

                  // pro.forecastweather = await apiService.fetchforcastfromlatlon(
                  //     latitude: pro.latitude, longitude: pro.longitude);

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
          ]),
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
                return Container(
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
                            color: themeprovider.themeMode ? ash : Colors.white,
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
                                          "${pro.weatherModel?.tempMax ?? 0}°"),
                                  SizedBox(
                                    width: screenSize.width * 0.06,
                                  ),
                                  weatherDetails(
                                      context: context,
                                      weatherlogo: "thermometericon",
                                      description: "feelslike",
                                      modelvalue:
                                          "${pro.weatherModel?.feelsLike ?? 0}°"),
                                  SizedBox(
                                    width: screenSize.width * 0.06,
                                  ),
                                  weatherDetails(
                                      context: context,
                                      weatherlogo: "visibilityicon",
                                      description: "visibility",
                                      modelvalue:
                                          "${pro.weatherModel?.visibility ?? 0}km")
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.03,
                        ),
                        SizedBox(
                          height: 200,
                          width: screenSize.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 12,
                            itemBuilder: (context, index) {
                              return Container(
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
                                child: Column(
                                  children: [
                                    HourlyData(
                                      temperature: pro.forecastweather!
                                          .hourly![index].temp!,
                                      timestamp: pro
                                          .forecastweather!.hourly![index].dt!,
                                      weathericon: pro
                                          .forecastweather!
                                          .hourly![index]
                                          .weather![0]
                                          .description!,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
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