// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/model/forecastweather/forecastweather.dart';
import 'package:weather_app/model/weather/weather_model.dart';
import 'package:http/http.dart' as http;

//creating a class to perform api services
class ApiService {
  //here is the function for calling the api when we search for a location,
  //we are accepting a string value as location,and passes the value as cityname to the api call
  Future<dynamic> fetchdatafromApi(String? location) async {
    print("fetch data function called");
    print("LOCATION IN API CALL $location");
    //we are parcing the uri to a variable called apilink,
    final apiLink =
        Uri.parse("$apiDomain=$location&appid=$apiKey&units=metric");

    //storing the api responce to a variable called responce
    final responce = await http.get(apiLink);

    //then we are assigning the body of the responce to a variable called apibody
    final apiBody = jsonDecode(responce.body);

    //here we are checking the status of the api call if status code is 200 ,that means the call is successful
    if (responce.statusCode == 200) {
      print("--Api call successful--");

      print(responce.statusCode);

      print(responce.body);

      //we are returning the responce body to the json function in the modelclass
      return WeatherModel.fromJson(apiBody);
    } else {
      //if the status code is not 200 the call was failed
      print("Api call failed");
    }
  }

//this is the function to get the weather data of currentlocation ,this is the function we are calling
// in the provider after getting latitude and longitude
  Future<dynamic> fetchdatafromlatlon(
      var latitude,var longitude) async {
    print("fetch data from lat lon function called");
//we are parcing the uri to a variable called apilink,
    final apiLink = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric");
        print("hhhhhhhhhhhhhh");
    //storing the api responce to a variable called responce
    final responce = await http.get(apiLink);
 print("88888888888888");
    //then we are assigning the body of the responce to a variable called apibody
    final apiBody = jsonDecode(responce.body);
       

    //here we are checking the status of the api call if status code is 200 ,that means the call is successful
    if (responce.statusCode == 200) {
      print("--Api call successful--");

      print(responce.statusCode);

      print(responce.body);
      //we are returning the responce body to the json function in the modelclass
      return WeatherModel.fromJson(apiBody);
    } else {
      //if the status code is not 200 the call was failed
      print("Api call failed");
    }
  }

  Future<dynamic> fetchforcastfromlatlon(
      {var latitude, var longitude}) async {
    print("fetch forcast from lat lon function called");

    final apiLink = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=-$longitude&exclude=minutely&appid=4a6b9877b03bb8e33aa7ab12839c2bc8&units=metric");

    final responce = await http.get(apiLink);

    final apiBody = jsonDecode(responce.body);

    if (responce.statusCode == 200) {
      print("--forecast Api call successful--");

      print("forcast status${responce.statusCode}");

      print(responce.body);

      return Forecastweather.fromJson(apiBody);
    } else {
      print("forecast Api call failed");
    }
  }
}
