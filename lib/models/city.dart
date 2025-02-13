class City {
  final String date;
  final String name;
  final double temperature;
  final double windSpeed;
  final String weatherDescription;
  final int humidity;
  final int cloudiness;
  final int visibility;

  City({
    required this.date,
    required this.name,
    required this.temperature,
    required this.windSpeed,
    required this.weatherDescription,
    required this.humidity,
    required this.cloudiness,
    required this.visibility,
  });

  // Factory pour convertir les données JSON de l'API en un objet City
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      date: json['dt_txt'].split(' ')[0],
      name: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      weatherDescription: json['weather'][0]['description'] ?? '',
      humidity: json['main']['humidity'] as int,
      cloudiness: json['clouds']['all'] as int,
      visibility: json['visibility'] as int,
    );
  }
}
