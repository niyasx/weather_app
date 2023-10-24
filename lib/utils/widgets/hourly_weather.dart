import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/widgets/climateimage.dart';

class HourlyData extends StatelessWidget {
  double temperature;
  int timestamp;
  String weathericon;
  HourlyData(
      {super.key,
      required this.temperature,
      required this.timestamp,
      required this.weathericon});
  String getTime(final timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Text(
                temperature.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w600),
              ),
              Text(
                getTime(timestamp),
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w600),
              ),
              getClimateImage(weathericon)
            ],
          ),
        )
      ],
    );
  }
}
