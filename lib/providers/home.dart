import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/models/city.dart';
import 'package:weathernow/models/location.dart';
import 'package:weathernow/services/weather.dart';

// Provider pour le chargement du home page
final loaderProvider = StateProvider<bool>((ref) => false);

// Provider pour le nom de la ville
final cityNameProvider = StateProvider<String>((ref) => "");

// Provider pour la localisation de l'utilisateur
final locationProvider = StateProvider<Location?>((ref) => null);

// Provider pour le service de récupération des données météo
final weatherServiceProvider = Provider((ref) => WeatherService());

// Notifier pour gérer les données météo
class WeatherNotifier extends StateNotifier<AsyncValue<List<City>>> {
  final WeatherService weatherService;
  final Ref ref;

  WeatherNotifier(this.weatherService, this.ref)
      : super(const AsyncValue.loading());

  Future<void> fetchWeather() async {
    final cityName = ref.read(cityNameProvider);
    final location =
        ref.read(locationProvider) ?? Location(latitude: 0, longitude: 0);
    try {
      final weatherData = await weatherService.fetchWeather(cityName, location);
      state = AsyncValue.data(weatherData);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

// Provider pour récupérer les données météo
final weatherProvider =
    StateNotifierProvider<WeatherNotifier, AsyncValue<List<City>>>((ref) {
  final service = ref.watch(weatherServiceProvider);
  return WeatherNotifier(service, ref);
});
