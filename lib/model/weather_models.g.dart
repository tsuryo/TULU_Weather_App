// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      (json['id'] as num).toInt(),
      json['main'] as String,
      json['description'] as String,
      json['icon'] as String,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
      (json['temp'] as num).toInt(),
      (json['feels_like'] as num).toInt(),
      (json['temp_min'] as num).toInt(),
      (json['temp_max'] as num).toInt(),
      (json['pressure'] as num).toInt(),
      (json['humidity'] as num).toInt(),
      (json['sea_level'] as num).toInt(),
      (json['grnd_level'] as num).toInt(),
    );

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.seaLevel,
      'grnd_level': instance.groundLevel,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      (json['speed'] as num).toDouble(),
      (json['deg'] as num).toInt(),
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.directionDegrees,
    };

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      Temperature.fromJson(json['main'] as Map<String, dynamic>),
      (json['visibility'] as num).toInt(),
      Wind.fromJson(json['wind'] as Map<String, dynamic>),
      (json['dt'] as num).toInt(),
      json['name'] as String?,
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'main': instance.temperature,
      'visibility': instance.visibility,
      'wind': instance.wind,
      'dt': instance.dataTime,
      'name': instance.location,
    };
