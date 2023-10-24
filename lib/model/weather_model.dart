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
  double? visibility;
  num? speed;

  WeatherModel({
    this.cityName,
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
    feelsLike = json["main"]["feels_like"];
    tempMin = json["main"]["temp_min"];
    tempMax = json["main"]["temp_max"];
    humidity = json["main"]["humidity"];
    visibility = json["visibility"] * 0.001;
    clouds = json["clouds"]["all"];
    pressure = json["main"]["pressure"];
    speed = json["wind"]["speed"];
  }
}
