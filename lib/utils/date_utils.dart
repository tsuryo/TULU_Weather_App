import 'package:intl/intl.dart';
import 'package:weather_tulu_app/model/forecast_models.dart';
import 'package:weather_tulu_app/model/weather_models.dart';
import 'package:weather_tulu_app/model/daily_weather.dart';

class DateUtils {
  static List<DailyWeather> generateDailyWeatherList(FiveDayForcast forecast) {
    Map<String, List<WeatherResponse>> groupedByDay = {};

    for (var weatherResponse in forecast.forecasts) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(weatherResponse.dataTime * 1000);
      String dayKey = DateFormat('yyyy-MM-dd').format(date);

      if (!groupedByDay.containsKey(dayKey)) {
        groupedByDay[dayKey] = [];
      }
      groupedByDay[dayKey]!.add(weatherResponse);
    }

    List<DailyWeather> dailyWeatherList = [];
    bool firstSkipped = false;
    groupedByDay.forEach((dayKey, weatherResponses) {
      if (!firstSkipped) {
        firstSkipped = true;
        return;
      }
      double tempSum = 0;

      int middleIndex = weatherResponses.length ~/ 2;
      String icon = weatherResponses[middleIndex].weather.first.icon;

      for (var response in weatherResponses) {
        double temp = response.temperature.temp.toDouble();
        tempSum += temp;
      }

      double avgTemp = tempSum / weatherResponses.length;

      DateTime date = DateTime.parse(dayKey);
      String dayName = DateFormat("E").format(date);

      dailyWeatherList.add(
        DailyWeather(
          dayName,
          avgTemp.toInt(),
          icon,
        ),
      );
    });

    return dailyWeatherList;
  }
}
