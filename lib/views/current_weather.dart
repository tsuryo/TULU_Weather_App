import 'package:flutter/material.dart';
import 'package:weather_tulu_app/model/weather_models.dart';
import 'package:weather_tulu_app/views/weather_image.dart';
import 'package:weather_tulu_app/views/wind.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final WeatherResponse weatherResponse;

  const CurrentWeatherWidget({super.key, required this.weatherResponse});

  @override
  CurrentWeatherWidgetState createState() => CurrentWeatherWidgetState();
}

class CurrentWeatherWidgetState extends State<CurrentWeatherWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.weatherResponse.location!;
    final weatherInfo = widget.weatherResponse.weather.first;
    final temperature = widget.weatherResponse.temperature;
    final wind = widget.weatherResponse.wind;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          children: [
            Text(
              location,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            WeatherImageIcon(icon: weatherInfo.icon),
            Text(
              "${temperature.temp}°",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              weatherInfo.main,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              weatherInfo.description,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 24),
            Text(
              "${temperature.tempMax}° / ${temperature.tempMin}° Feels Like ${temperature.feelsLike}°",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            WindDirectionWidget(wind: wind),
          ],
        ),
      ),
    );
  }
}
