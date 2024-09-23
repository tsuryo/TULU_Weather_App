// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiveDayForcast _$FiveDayForcastFromJson(Map<String, dynamic> json) =>
    FiveDayForcast(
      (json['list'] as List<dynamic>)
          .map((e) => WeatherResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FiveDayForcastToJson(FiveDayForcast instance) =>
    <String, dynamic>{
      'list': instance.forecasts,
    };
