// ignore_for_file: avoid_print
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/forecastweather/forecastweather.dart';
import 'package:weather_app/model/weather/weather_model.dart';
import 'package:weather_app/services/api_services.dart';

class LocationProvider with ChangeNotifier {
  //initialising variables and objects,
  Position? latLonposition;
  Placemark? decodeData;
  //object of weather model class
  WeatherModel? weatherModel;
  //object of forecast weather model class
  Forecastweather? forecastweather;
  //object of api calling class
  ApiService apiService = ApiService();

  double? latitude;
  double? longitude;

//this is the function to perform all the location services,in this function initially we call the function to get
//latitude and longitude  from _getCurrentLocation function ,then we store the latitude and longitude values to the
// variable named latlonposition,after that we call the api calling function and pass
//the lata and lon to that function and makes the api call,

  Future<void> getCurrentLocation() async {
    print("getcurrrent location is called");

    //Assigning the lat&lon value to the latlonposition variable
    latLonposition = await _getCurrentLatLonPosition();

    print("lat & lon got successfully==${latLonposition.toString()}");

    //making the api call using the lat and lon value ,and we store the api responce to the object(weathermodel) of our model class.
    weatherModel = await apiService.fetchdatafromlatlon(
        latLonposition?.latitude.toString(),
        latLonposition?.longitude.toString());
print('objehhhhhhhhhhct');
    forecastweather = await apiService.fetchforcastfromlatlon(
        latitude: latLonposition?.latitude,
        longitude: latLonposition?.longitude);
print('object');
    // await _getAddressFromLatLon(latLonposition!);
    notifyListeners();
  }

  Future<Position> _getCurrentLatLonPosition() async {
    //initializing the geolocator
    LocationPermission permission = await Geolocator.checkPermission();

    //making conditions
    if (permission == LocationPermission.denied) {
      //requesting the device's location permission if the permission is desabled initially,
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    //returns the latitude and longitude values
    return await Geolocator.getCurrentPosition(
        //setting the accuracy of location is to high for best experience
        desiredAccuracy: LocationAccuracy.high);
  }

//encoding location name to latitude and longitude
  Future<void> getLatandLonFromAddress(String address) async {
    await locationFromAddress(address).then((locations) {
      latitude = locations[0].latitude;
      longitude = locations[0].longitude;
      print(
          "000000000${locations[0].latitude} ${locations[0].longitude} 3333333333333");
    });
  }


  Future<void> refreshWeatherData() async {
  // Call the API to fetch updated weather data.
  weatherModel = await apiService.fetchdatafromlatlon(
      latLonposition?.latitude.toString(),
      latLonposition?.longitude.toString());

  forecastweather = await apiService.fetchforcastfromlatlon(
      latitude: latLonposition?.latitude,
      longitude: latLonposition?.longitude);

  notifyListeners();
}
}
