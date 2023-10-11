import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/api_services.dart';

class LocationProvider with ChangeNotifier {
  Position? latLonposition;
  Placemark? decodeData;
  WeatherModel? model;
  ApiService apiService = ApiService();

  Future<void> getCurrentLocation() async {
    latLonposition = await _getCurrentLatLonPosition();

    print("lat & lon got successfully==${latLonposition.toString()}");

   await _getAddressFromLatLon(latLonposition!);

    notifyListeners();
  }

  Future<Position> _getCurrentLatLonPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  // decoding lat and lon  using geodecode package And get full details
  Future<void> _getAddressFromLatLon(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((placemarks) async{
      decodeData = placemarks[0];

      print(
          "successfully decoded lat and lon==\n${decodeData}\n**********");

      currentlocation =  decodeData!.locality.toString();
       model=await apiService.fetchdatafromApi(currentlocation);

      print("currentlocation in geocode==$currentlocation");
    }).catchError((e) {
      debugPrint(e);
    });
    notifyListeners();
  }


}
