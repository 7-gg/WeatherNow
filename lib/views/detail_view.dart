import 'package:flutter/material.dart';
import 'package:weathernow/helpers/function.dart';
import 'package:weathernow/helpers/screen_size.dart';
import 'package:weathernow/models/city_model.dart';
import 'package:weathernow/components/weather_icon.dart';

class DetailPage extends StatefulWidget {
  final City city;
  final String cityName;
  const DetailPage({super.key, required this.city, required this.cityName});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fond flouté avec une image d'arrière-plan
          Stack(
            children: [
              Image.asset(
                weatherDescriptionImage(widget.city.weatherDescription),
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
                    color: Colors.redAccent, // Améliorer la visibilité
                  ),
                ),
              ),
            ],
          ),
          // Contenu principal
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
                    // Nom de la ville et date
                    Center(
                      child: Column(
                        children: [
                          Text(
                            widget.cityName,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[800],
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Text(
                            widget.city.date,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    // Description de la météo et température
                    Center(
                      child: Column(
                        children: [
                          Text(
                            widget.city.weatherDescription,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            '${widget.city.temperature}°C',
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
                    // Détails supplémentaires
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
                          '${widget.city.visibility} km',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[600],
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    // Icônes de météo (nuageux, humidité, vitesse du vent)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WeatherIconWidget(
                          iconPath: "assets/images/cloudiness.png",
                          value: 'cloud',
                          label: widget.city.cloudiness.toString(),
                        ),
                        SizedBox(width: ScreenSize.getWidth(context) * 0.12),
                        WeatherIconWidget(
                          iconPath: 'assets/images/humidity.png',
                          value: 'Humidity',
                          label: widget.city.humidity.toString(),
                        ),
                        SizedBox(width: ScreenSize.getWidth(context) * 0.12),
                        WeatherIconWidget(
                          iconPath: 'assets/images/windspeed.png',
                          value: 'wind speed',
                          label: widget.city.windSpeed.toString(),
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
