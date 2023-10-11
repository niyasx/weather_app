// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_app/viewmodel/provider/weather_provider.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(Duration(seconds: 10), () {
//       Navigator.of(context).pushNamed('/home');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//      final locationProvider = Provider.of<LocationProvider>(context);

//     // Check if the location data is available
//     if (locationProvider.latLonposition == null) {
//       return Center(
//         child: CircularProgressIndicator(), // Show a loading indicator while getting location data
//       );
//     }

//     // Access the location name from your provider
//     final locationName = locationProvider.decodeData?.locality ?? "Unknown";

//     return Scaffold(
//       body: Stack(
//         children: [

//           Image.asset(
//             'assets/images/sky.jpg',
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),

//           Center(
//             child: Image.asset(
//               'assets/images/giphy.gif',
//               width: 150,
//               height: 150,
//             ),
//           ),

//           Text(locationName,
//           style: TextStyle(
//             fontSize: 50
//           ),)
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/api_services.dart';
import 'package:weather_app/view/home_page.dart';

import 'package:weather_app/viewmodel/provider/weather_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  bool locationDataAvailable = false;

  @override
  void initState() {
    super.initState();

    getLocationData();
    print("Called getlocationdata in initstate");
    
  }



  Future<void> getLocationData() async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
   
    try {
     
      await locationProvider.getCurrentLocation();
     
      setState(() {
        locationDataAvailable = true;
      });
      if (locationProvider.latLonposition==null) {
        
        print("current location is not feched");
      }else{

          print("Got lat&lon in splashscreen");
        // var   weatherModel= await apiService.fetchdatafromApi(currentlocation);
    //  Future.delayed(Duration(seconds: 5));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));}
    } catch (e) {
     

      print("Error fetching location data: $e");
    }
  }


  // Future<void> getData() async {
  //   print("CALLED GET DATA FUNCTION");
  //   // await Future.delayed(const Duration(seconds: 2));
  //   await apiService.fetchdatafromApi(currentlocation);
  //   print("ENDED GETDATA FUNCTION");
  // }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    // Use the isLoadingLocation flag to conditionally display the GIF or location data
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/sky.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child:
             locationDataAvailable
                // ? Image.asset(
                //     'assets/images/giphy.gif',
                //     width: 150,
                //     height: 150,
                //   )
                // : Text(
                //     locationProvider.decodeData?.locality ?? "Unknown",
                //     style: TextStyle(fontSize: 50),
                //   ),
                ? Text(
                    locationProvider.decodeData?.locality ?? "Unknown",
                    style: TextStyle(fontSize: 50),
                  )
                : 
                Image.asset(
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
