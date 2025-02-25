import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weathernow/helpers/screen_size.dart';
import 'package:weathernow/components/weather_card.dart';
import 'package:weathernow/components/weather_icon.dart';

class TodayWidget extends StatelessWidget {
  final String description;
  final String temperature;
  final String cityName;
  final String date;
  final String iconPath;
  final String cloudiness;
  final String windSpeed;
  final String humidity;

  // Constructeur
  const TodayWidget({
    super.key,
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.date,
    required this.iconPath,
    required this.cloudiness,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            // Texte animé
            Text(
              cityName.toUpperCase(),
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
                .animate()
                .fadeIn(duration: 1.seconds) // Animation d'apparition
                .moveY(begin: -50, end: 0, duration: 1.seconds),
            SizedBox(width: 30, child: Divider()),
            SizedBox(height: 15),
            WeatherCardWidget(
              temperature: temperature,
              description: description,
              date: date,
              iconPath: iconPath,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WeatherIconWidget(
                    iconPath: "assets/images/cloudiness.png",
                    value: 'cloud',
                    label: cloudiness),
                SizedBox(width: ScreenSize.getWidth(context) * 0.12),
                WeatherIconWidget(
                    iconPath: 'assets/images/humidity.png',
                    value: 'Humidity',
                    label: humidity),
                SizedBox(width: ScreenSize.getWidth(context) * 0.12),
                WeatherIconWidget(
                    iconPath: 'assets/images/windspeed.png',
                    value: 'wind speed',
                    label: windSpeed),
              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
