// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/helpers/function.dart';
import 'package:weathernow/helpers/screen_size.dart';
import 'package:weathernow/components/weather_icon.dart';
import 'package:weathernow/providers/detail.dart';
import 'package:weathernow/providers/home.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cityName = ref.watch(cityNameProvider);
    // Retrieve the value of `City` from the provider
    final city = ref.watch(detailProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Blurred background with a background image
          Stack(
            children: [
              Image.asset(
                weatherDescriptionImage(city!.weatherDescription),
                width: ScreenSize.getWidth(context),
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.redAccent, // Improve visibility
                  ),
                ),
              ),
            ],
          ),
          // Main content
          Column(
            children: [
              Spacer(),
              Container(
                height: ScreenSize.getHeight(context) * 0.78,
                width: ScreenSize.getWidth(context),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Color.fromARGB(255, 240, 209, 209)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // City name and date
                    Center(
                      child: Column(
                        children: [
                          Text(
                            cityName,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[800],
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Text(
                            city.date,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    // Weather description and temperature
                    Center(
                      child: Column(
                        children: [
                          Text(
                            city.weatherDescription,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            '${city.temperature}°C',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    // Additional details
                    Row(
                      children: [
                        SizedBox(
                          width: ScreenSize.getWidth(context) * 0.4,
                          child: Text(
                            'Visibility',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${city.visibility} km',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[600],
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    // Weather icons (cloudiness, humidity, wind speed)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WeatherIconWidget(
                          iconPath: "assets/images/cloudiness.png",
                          value: 'cloud',
                          label: city.cloudiness.toString(),
                        ),
                        SizedBox(width: ScreenSize.getWidth(context) * 0.12),
                        WeatherIconWidget(
                          iconPath: 'assets/images/humidity.png',
                          value: 'Humidity',
                          label: city.humidity.toString(),
                        ),
                        SizedBox(width: ScreenSize.getWidth(context) * 0.12),
                        WeatherIconWidget(
                          iconPath: 'assets/images/windspeed.png',
                          value: 'wind speed',
                          label: city.windSpeed.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
