import 'package:json_annotation/json_annotation.dart';

part 'weather_models.g.dart';

@JsonSerializable()
class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather(this.id, this.main, this.description, this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Temperature {
  final int temp;
  @JsonKey(name: "feels_like")
  final int feelsLike;
  @JsonKey(name: "temp_min")
  final int tempMin;
  @JsonKey(name: "temp_max")
  final int tempMax;
  final int pressure;
  final int humidity;
  @JsonKey(name: "sea_level")
  final int seaLevel;
  @JsonKey(name: "grnd_level")
  final int groundLevel;

  Temperature(this.temp, this.feelsLike, this.tempMin, this.tempMax,
      this.pressure, this.humidity, this.seaLevel, this.groundLevel);

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);
  Map<String, dynamic> toJson() => _$TemperatureToJson(this);
}

@JsonSerializable()
class Wind {
  final double speed; //meters/second
  @JsonKey(name: "deg")
  final int directionDegrees;

  Wind(this.speed, this.directionDegrees);

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class WeatherResponse {
  final List<Weather> weather;
  @JsonKey(name: "main")
  final Temperature temperature;
  final int visibility;
  final Wind wind;
  @JsonKey(name: "dt")
  final int dataTime;
  @JsonKey(name: "name")
  final String? location;

  WeatherResponse(this.weather, this.temperature, this.visibility, this.wind,
      this.dataTime, this.location);

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
