import 'dart:convert';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiService{

Future<dynamic> fetchdatafromApi(String? location)async{
  
  print("LOCATION IN API CALL $location");

  
  final apiLink=Uri.parse("$apiDomain=$location&appid=$apiKey&units=metric");
  final responce= await http.get(apiLink); 
    print(responce.body);

  final apiBody=jsonDecode(responce.body);
  if (responce.statusCode==200) {

    print("--Api call successful--");

    print(responce.statusCode);

    print(responce.body);
             
    return WeatherModel.fromJson(apiBody);

  }else{

    print("Api call failed");

    
  }
}
}