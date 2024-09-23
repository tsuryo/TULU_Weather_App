import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_tulu_app/model/forecast_models.dart';
import 'package:weather_tulu_app/model/weather_models.dart';

part 'weather_service.g.dart';

@RestApi(baseUrl: "http://api.openweathermap.org/")
abstract class WeatherService {
  factory WeatherService(Dio dio, {String baseUrl}) = _WeatherService;

  @GET("/data/2.5/weather")
  Future<WeatherResponse> getWeatherByLocation(
    @Query("lat") double latitude,
    @Query("lon") double longitude,
    @Query("appid") String apiKey,
    @Query("units") String units,
  );

  @GET("data/2.5/forecast")
  Future<FiveDayForcast> getFiveDayForecast(
    @Query("lat") double latitude,
    @Query("lon") double longitude,
    @Query("appid") String apiKey,
    @Query("units") String units,
  );
}
