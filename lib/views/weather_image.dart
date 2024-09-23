import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeatherImageIcon extends StatelessWidget {
  static const String _iconsUrl = "https://openweathermap.org/img/wn/";

  const WeatherImageIcon({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$_iconsUrl$icon@2x.png",
      placeholder: (context, url) => Opacity(
        opacity: 0.05,
        child: Image.asset(
          'assets/images/placeholder.png',
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 32,
      ),
    );
  }
}
