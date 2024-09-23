import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_tulu_app/dao/weather_repository.dart';
import 'package:weather_tulu_app/pages/weather_viewmodel.dart';
import 'package:weather_tulu_app/utils/location_manager.dart';
import 'package:weather_tulu_app/views/current_weather.dart';
import 'package:weather_tulu_app/views/forecast/daily_forecast_list_item.dart';
import 'package:weather_tulu_app/views/gradient_background.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherViewModel(
        Provider.of<WeatherRepository>(context, listen: false),
        Provider.of<LocationManager>(context, listen: false),
      ),
      child: const WeatherContent(),
    );
  }
}

class WeatherContent extends StatelessWidget {
  const WeatherContent({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);
    final isCurrentLoading = weatherViewModel.isLoading;
    final currentWeather = weatherViewModel.currentWeather;
    final isForecastLoading = weatherViewModel.isForecastLoading;
    final fiveDayForecast = weatherViewModel.fiveDayForecast;
    final currentErrorMsg =
        weatherViewModel.errorMessage ?? "No current data available";
    final forecastErrorMsg =
        weatherViewModel.forcastErrorMessage ?? "No forecast data available";

    final screenHeight = MediaQuery.of(context).size.height;
    final pgHeight = screenHeight * 0.3;

    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(title: const Text("TULU Weather")),
        body: Center(
          child: ListView(
            children: [
              isCurrentLoading
                  ? SizedBox(
                      height: pgHeight,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : currentWeather == null
                      ? SizedBox(
                          height: pgHeight,
                          child: Center(
                            child: Text(currentErrorMsg),
                          ),
                        )
                      : CurrentWeatherWidget(
                          weatherResponse: currentWeather,
                        ),
              const SizedBox(height: 60),
              isForecastLoading
                  ? SizedBox(
                      height: pgHeight,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : fiveDayForecast == null
                      ? SizedBox(
                          height: pgHeight,
                          child: Center(
                            child: Text(forecastErrorMsg),
                          ),
                        )
                      : ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 300),
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: fiveDayForecast.length,
                              itemBuilder: (context, index) {
                                return DailyWeatherListItem(
                                  weather: fiveDayForecast[index],
                                );
                              },
                            ),
                          ),
                        )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            weatherViewModel.refreshAll();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
