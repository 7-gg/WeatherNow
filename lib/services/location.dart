import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathernow/models/location.dart';
import 'package:weathernow/providers/home.dart';

class LocationButton extends ConsumerWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async => await getCurrentLocation(context, ref),
      icon: Icon(
        Icons.location_on,
        size: 32,
      ),
    );
  }
}

Future<void> getCurrentLocation(BuildContext context, WidgetRef ref) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    _showDialog(context, 'Location Service Disabled',
        'Please enable location services.');
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _showDialog(
          context, 'Permission Denied', 'Please allow location access.');
      return;
    }
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Mettre à jour la localisation dans Riverpod
    ref.read(locationProvider.notifier).state =
        Location(latitude: position.latitude, longitude: position.longitude);

    // Appeler fetchWeather avec la nouvelle localisation
    ref.read(weatherProvider.notifier).fetchWeather();
  } catch (e) {
    _showDialog(context, 'Error', 'Unable to get location.');
  }
}

void _showDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    ),
  );
}
