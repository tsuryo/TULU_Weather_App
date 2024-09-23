import 'package:flutter/material.dart';
import 'package:weather_tulu_app/model/daily_weather.dart';
import 'package:weather_tulu_app/views/weather_image.dart';

class DailyWeatherListItem extends StatefulWidget {
  final DailyWeather weather;

  const DailyWeatherListItem({super.key, required this.weather});

  @override
  DailyWeatherListItemState createState() => DailyWeatherListItemState();
}

class DailyWeatherListItemState extends State<DailyWeatherListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideTopAnimation;
  late Animation<Offset> _slideBottomAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _slideTopAnimation = Tween<Offset>(
            begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0))
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _slideBottomAnimation = Tween<Offset>(
            begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0))
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DailyWeather weather = widget.weather;
    return SizedBox(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            SlideTransition(
              position: _slideTopAnimation,
              child: Text(
                weather.day,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            WeatherImageIcon(icon: weather.icon),
            SlideTransition(
              position: _slideBottomAnimation,
              child: Text(
                "${weather.avgTemperature}°",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
