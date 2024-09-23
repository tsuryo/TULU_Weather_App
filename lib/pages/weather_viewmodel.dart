import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_tulu_app/dao/weather_repository.dart';
import 'package:weather_tulu_app/model/daily_weather.dart';
import 'package:weather_tulu_app/model/weather_models.dart';
import 'package:weather_tulu_app/utils/date_utils.dart';
import 'package:weather_tulu_app/utils/location_manager.dart';

class WeatherViewModel extends ChangeNotifier {
  static const _units = "metric";

  bool _isLoading = false;
  bool _isForecastLoading = false;
  final WeatherRepository _weatherRepository;
  final LocationManager locationManager;

  WeatherResponse? _currentWeather;
  List<DailyWeather>? _fiveDayForecast;
  String? _errorMessage;
  String? _forcastErrorMessage;

  WeatherViewModel(this._weatherRepository, this.locationManager) {
    refreshAll();
  }

  bool get isLoading => _isLoading;
  WeatherResponse? get currentWeather => _currentWeather;
  String? get errorMessage => _errorMessage;

  bool get isForecastLoading => _isForecastLoading;
  List<DailyWeather>? get fiveDayForecast => _fiveDayForecast;
  String? get forcastErrorMessage => _forcastErrorMessage;

  Future<void> refreshAll() async {
    Position position;
    try {
      _isLoading = true;
      _isForecastLoading = true;
      _errorMessage = null;
      _forcastErrorMessage = null;
      notifyListeners();

      position = await locationManager.getCurrentLocation();
    } catch (e) {
      _errorMessage = "";
      _forcastErrorMessage = e.toString();
      _isForecastLoading = false;
      _isLoading = false;
      notifyListeners();
      return;
    }
    fetchWeatherByLocation(position);
    fetchFiveDayForecast(position);
  }

  Future<void> fetchWeatherByLocation(Position position) async {
    try {
      _currentWeather = await _weatherRepository.fetchWeatherByLocation(
        position.latitude,
        position.longitude,
        _units,
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFiveDayForecast(Position position) async {
    try {
      var forecast = await _weatherRepository.fetchFiveDayForecast(
        position.latitude,
        position.longitude,
        _units,
      );
      _fiveDayForecast = DateUtils.generateDailyWeatherList(forecast);
      _forcastErrorMessage = null;
    } catch (e) {
      _forcastErrorMessage = e.toString();
    }
    _isForecastLoading = false;
    notifyListeners();
  }
}
