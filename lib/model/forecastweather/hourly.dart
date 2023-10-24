import 'weather.dart';

class Hourly {
  var dt;
  var temp;
  var feelsLike;
  var pressure;
  var humidity;
  var dewPoint;
  var uvi;
  var clouds;
  var visibility;
  var windSpeed;
  var windDeg;
  var windGust;
  List<Weather>? weather;
  var pop;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['dt'],
        temp: json['temp'],
        feelsLike: json['feels_like'],
        pressure: json['pressure'],
        humidity: json['humidity'] ,
        dewPoint: json['dew_point'] ,
        uvi: json['uvi'],
        clouds: json['clouds'],
        visibility: json['visibility'],
        windSpeed: json['wind_speed'] ,
        windDeg: json['wind_deg'],
        windGust: json['wind_gust'] ,
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        pop: json['pop'],
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'feels_like': feelsLike,
        'pressure': pressure,
        'humidity': humidity,
        'dew_point': dewPoint,
        'uvi': uvi,
        'clouds': clouds,
        'visibility': visibility,
        'wind_speed': windSpeed,
        'wind_deg': windDeg,
        'wind_gust': windGust,
        'weather': weather?.map((e) => e.toJson()).toList(),
        'pop': pop,
      };
}
