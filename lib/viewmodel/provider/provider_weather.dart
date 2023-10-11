// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';



// class LocPermissionProvider with ChangeNotifier {
//   Position? latLonposition;
//   Placemark? decodeData;
//   bool boolVisibility = true;
//   LocPermissionProvider() {
//     getCurrentLocation();
//   }

//   Future<void> getCurrentLocation() async {
//     latLonposition = await _getCurrentLatLonPosition();
//     print(
//         "${latLonposition.toString()}successfully get lat and lon////////////////////");
//     _getAddressFromLatLon(latLonposition!);
//     notifyListeners();
//   }

//   Future<Position> _getCurrentLatLonPosition() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }

//   // decoding lat and lon  using geodecode package And get full detauls
//   Future<void> _getAddressFromLatLon(Position position) async {
//     await placemarkFromCoordinates(position.latitude, position.longitude)
//         .then((placemarks) {
//       decodeData = placemarks[0];
//       print("//////////////successfully  DECODEd$decodeData");
//       currentLocation = decodeData!.locality.toString();
//       print(currentLocation);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//     notifyListeners();
//   }

//   ///////////////////////////////////////////////////////////
//   void statemanagement() {
//     boolVisibility = !boolVisibility;
//     notifyListeners();
//   }
// }
