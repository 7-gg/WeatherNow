// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weathernow/models/city.dart';
import 'package:weathernow/models/location.dart';

class WeatherService {
  final String apiKey = 'b99077846337e6e64800b68d5b80cdae';

  Future<List<City>> fetchWeather(String city, Location location) async {
    final url = city.isNotEmpty
        ? 'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric'
        : 'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';

    print('Call API URL WeatherService: $url');

    try {
      final response = await http.get(Uri.parse(url));

      final data = json.decode(response.body);
      print('API Response: $data');

      if (response.statusCode == 200) {
        // Vérifier si la clé 'list' est bien présente dans la réponse
        if (data['list'] == null) {
          throw Exception("Données météo indisponibles");
        }

        // Définir la liste des prévisions météo
        List<City> weatherDataList = [];
        for (var item in data['list']) {
          String date = item['dt_txt'].split(' ')[0]; // Extraire la date
          if (!weatherDataList.any((element) => element.date == date)) {
            weatherDataList.add(City.fromJson(item));
          }
        }
        return weatherDataList;
      } else {
        throw Exception(
            'Erreur HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Erreur lors de la récupération des données : $e');
      return [];
    }
  }
}
