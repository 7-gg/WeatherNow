import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/models/city_model.dart';
import 'package:weathernow/services/weather_service.dart';

final weatherServiceProvider = Provider((ref) => WeatherService());

final weatherProvider = FutureProvider.family<List<City>, String>((ref, city) {
  final service = ref.watch(weatherServiceProvider);
  return service.fetchWeather(city);
});
