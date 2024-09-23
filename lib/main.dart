import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:weather_tulu_app/utils/location_manager.dart';
import 'dao/weather_repository.dart';
import 'network/weather_service.dart';
import 'pages/weather_page.dart';

void main() {
  final dio = Dio();

  runApp(
    MultiProvider(
      providers: [
        Provider<Dio>(create: (_) => dio),
        Provider<LocationManager>(create: (_) => LocationManager()),
        ProxyProvider<Dio, WeatherService>(
          update: (_, dio, __) => WeatherService(dio),
        ),
        ProxyProvider<WeatherService, WeatherRepository>(
          update: (_, weatherService, __) => WeatherRepository(weatherService),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color white = Colors.white;
    const Color captionColor = Color.fromARGB(255, 225, 225, 225);
    const FontWeight bold = FontWeight.bold;

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(color: white, fontSize: 24),
        ),
        textTheme: const TextTheme(
          headlineLarge:
              TextStyle(fontWeight: bold, fontSize: 40, color: white),
          headlineMedium:
              TextStyle(fontWeight: bold, fontSize: 32, color: white),
          labelMedium: TextStyle(fontWeight: bold, fontSize: 20, color: white),
          labelSmall: TextStyle(fontSize: 16, color: captionColor),
          bodySmall: TextStyle(fontWeight: bold, fontSize: 16, color: white),
        ),
      ),
      home: const WeatherScreen(),
    );
  }
}
