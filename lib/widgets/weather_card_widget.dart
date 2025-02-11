import 'package:flutter/material.dart';
import 'package:weathernow/helper/screen_size.dart';

class WeatherCardWidget extends StatelessWidget {
  final String temperature;
  final String description;
  final String date;
  final String iconPath;

  const WeatherCardWidget({
    Key? key,
    required this.temperature,
    required this.description,
    required this.date,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Température et détails météo
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$temperature°",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Today | $date",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          // Icône météo
          Image.asset(
            iconPath,
            width: ScreenSize.getWidth(context) * 0.4,
            height: ScreenSize.getHeight(context) * 0.15,
          ),
        ],
      ),
    );
  }
}
