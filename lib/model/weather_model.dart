// import 'dart:convert';

// WeatherModel weatherModelFromJson(String str) =>
//     WeatherModel.fromjson(json.decode(str));

// class WeatherModel {
//   String? cityname;
//   String? discription;
//   double? temperature;
//   double? maximumtemp;
//   double? minimumtemp;
//   int? pressure;
//   int? humidity;
//   int? visibility;
//   int? wind;

//   WeatherModel(
//     this.cityname,
//     this.discription,
//     this.temperature,
//     this.maximumtemp,
//     this.minimumtemp,
//     this.pressure,
//     this.humidity,
//     this.visibility,
//     this.wind,

//   );
//   WeatherModel.fromjson(Map<String, dynamic> json) {
//     cityname = json["name"];
//     discription = json['weather'][0]['description'];
//     temperature = json["main"]["temp"];
//     maximumtemp = json["main"]["temp_max"];
//     minimumtemp = json["main"]["temp_min"];
//     // pressure = json["main"]["pressure"];
//     // humidity = json["main"]["humidity"];
//     // visibility = json["visibility"];
//     wind = json["wind"]["speed"];
//   }
// }


class WeatherModel {
  String? cityName;
  String? description;
  double? temperature;
  int? clouds;
  int? humidity;
  int? pressure;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? visibility;
  double? speed;

  WeatherModel(
      {this.cityName,
      this.description,
      this.temperature,
      this.humidity,
      this.clouds,
      this.pressure,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.visibility,
      this.speed,
    });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    description = json["weather"][0]['description'];
    temperature = json["main"]["temp"];
    feelsLike= json["main"]["feels_like"];
    tempMin= json["main"]["temp_min"];
    tempMax= json["main"]["temp_max"];
    humidity = json["main"]["humidity"];
    visibility= json["visibility"];
    clouds = json["clouds"]["all"];
    pressure= json["main"]["pressure"];
    speed= json["wind"]["speed"];
  }
}
