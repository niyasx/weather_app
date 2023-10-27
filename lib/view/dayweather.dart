import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/utils/widgets/hourly_weather.dart';

class DayWeather extends StatelessWidget {
  final  pro;
  final themepro;
  const DayWeather({super.key, this.pro, this.themepro});

  @override
  Widget build(BuildContext context) {
    // Size screenSize=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              // height: screenSize.height,
              // width: screenSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueGrey
              ),
              child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 12,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 200,
                                  width:200,
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
                                              Color.fromARGB(255, 88, 115, 225),
                                              Color.fromARGB(255, 117, 176, 227)
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            tileMode: TileMode.clamp,
                                          ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: 
                                  HourlyDataForcast(
                                    temperature: pro
                                        .forecastweather!.hourly![index].temp!,
                                    timestamp:
                                        pro.forecastweather!.hourly![index].dt!,
                                    weathericon: pro
                                        .forecastweather!
                                        .hourly![index]
                                        .weather![0]
                                        .description!,
                                  ),
                                );
                              },
                            ),
            )
          ],
        ),
      ),
    );
  }
}