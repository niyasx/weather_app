// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/home_page.dart';
import 'package:weather_app/viewmodel/provider/weather_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool locationDataAvailable = false;
  @override
  void initState() {
    super.initState();
    print("calling getlocationdata");
    getLocationData();
    print("Called getlocationdata in initstate");
  }

  Future<void> getLocationData() async {
    print("getlocationdata is activated");
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    try {
      await locationProvider.getCurrentLocation();

      print("${locationProvider.latLonposition}kkkkkkkkkkkk");
      setState(() {
        locationDataAvailable = true;
      });
     
      if (locationProvider.latLonposition != null) {
        print("Got latitude and longitude in splashscreen");

        print("pushing to home page");

        await Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        print("current location is not feched");
      }
    } catch (e) {
      print(e);
      // throw Exception(e);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("unable to fetch your location"),
          );
        },
      );
      print("Error fetching location data: $e");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          // Image.asset(
          //   'assets/images/sky.jpg',
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // ),
          Center(
            child: locationDataAvailable
                ? Text(
                    locationProvider.weatherModel?.cityName ?? "Unknown",
                    style: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )
                : Image.asset(
                    'assets/images/giphy.gif',
                    width: 150,
                    height: 150,
                  ),
          ),
        ],
      ),
    );
  }
}
