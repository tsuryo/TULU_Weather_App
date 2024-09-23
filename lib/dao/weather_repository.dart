import 'package:weather_tulu_app/model/forecast_models.dart';
import 'package:weather_tulu_app/model/weather_models.dart';
import 'package:weather_tulu_app/network/weather_service.dart';

class WeatherRepository {
  static const String _apiKey = "c827adc2130d2752120c76311a2ff91f";
  final WeatherService _weatherService;

  WeatherRepository(this._weatherService);

  Future<WeatherResponse> fetchWeatherByLocation(
      double latitude, double longitude, String units) async {
    return await _weatherService.getWeatherByLocation(
      latitude,
      longitude,
      _apiKey,
      units,
    );
  }

  Future<FiveDayForcast> fetchFiveDayForecast(
      double latitude, double longitude, String units) async {
    return await _weatherService.getFiveDayForecast(
      latitude,
      longitude,
      _apiKey,
      units,
    );
  }
}
