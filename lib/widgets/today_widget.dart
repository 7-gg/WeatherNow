import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weathernow/helper/screen_size.dart';
import 'package:weathernow/widgets/weather_card_widget.dart';
import 'package:weathernow/widgets/weather_icon_widget.dart';

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
    Key? key,
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.date,
    required this.iconPath,
    required this.cloudiness,
    required this.humidity,
    required this.windSpeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Texte animé
            Text(
              cityName.toUpperCase(),
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
                .animate()
                .fadeIn(duration: 1.seconds) // Animation d'apparition
                .moveY(begin: -50, end: 0, duration: 1.seconds),
            Text(
              date,
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
            SizedBox(height: 15),
            WeatherCardWidget(
                temperature: temperature,
                description: description,
                date: date,
                iconPath: iconPath),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WeatherIconWidget(
                    iconPath: "assets/cloudiness.png",
                    value: 'nuage',
                    label: cloudiness),
                SizedBox(width: ScreenSize.getWidth(context) * 0.12),
                WeatherIconWidget(
                    iconPath: 'assets/humidity.png',
                    value: 'Humidité',
                    label: humidity),
                SizedBox(width: ScreenSize.getWidth(context) * 0.12),
                WeatherIconWidget(
                    iconPath: 'assets/windspeed.png',
                    value: 'vitesse',
                    label: windSpeed),
              ],
            )
          ],
        ),
      ),
    );
  }
}
