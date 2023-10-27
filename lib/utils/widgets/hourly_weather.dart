import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/widgets/climateimage.dart';

class HourlyData extends StatelessWidget {
  String temperature;
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
        Text(
          getTime(timestamp),
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.14,
            child: getClimateImage(weathericon)),
        Text(
          ("$temperature°C"),
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class HourlyDataForcast extends StatelessWidget {
  final double temperature;
  final int timestamp;
  final String weathericon;
  const HourlyDataForcast(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          getTime(timestamp),
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.14,
            child: getClimateImage(weathericon)),
        Text(
          ("${temperature.toString()}°C"),
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
