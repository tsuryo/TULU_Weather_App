import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather_tulu_app/model/weather_models.dart';

class WindDirectionWidget extends StatefulWidget {
  final Wind wind;

  const WindDirectionWidget({super.key, required this.wind});

  @override
  WindDirectionWidgetState createState() => WindDirectionWidgetState();
}

class WindDirectionWidgetState extends State<WindDirectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideRightAnimation;

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
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _slideAnimation = Tween<Offset>(
            begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _slideRightAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
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
    final double windSpeedKmh = widget.wind.speed * 3.6;
    final arrowAngle = (widget.wind.directionDegrees + 180) * (pi / 180);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: const Icon(Icons.air, size: 30, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Transform.rotate(
          angle: arrowAngle,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: const Icon(
              Icons.arrow_upward,
              size: 30,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(width: 10),
        FadeTransition(
          opacity: _fadeAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideRightAnimation,
              child: Text(
                "${windSpeedKmh.toStringAsFixed(1)} km/h",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
