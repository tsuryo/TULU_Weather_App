import 'package:json_annotation/json_annotation.dart';
import 'package:weather_tulu_app/model/weather_models.dart';

part 'forecast_models.g.dart';

@JsonSerializable()
class FiveDayForcast {
  @JsonKey(name: "list")
  List<WeatherResponse> forecasts;

  FiveDayForcast(this.forecasts);

  factory FiveDayForcast.fromJson(Map<String, dynamic> json) =>
      _$FiveDayForcastFromJson(json);
  Map<String, dynamic> toJson() => _$FiveDayForcastToJson(this);
}
