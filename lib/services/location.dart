import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation(
    BuildContext context, WidgetRef ref) async {
  print('getCurrentLocation start');
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print('Location Service Disabled');
    _showDialog(context, 'Location Service Disabled',
        'Please enable location services.');
    return null;
  }
  print("location service enabled");

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("location permission denied");
      _showDialog(
          context, 'Permission Denied', 'Please allow location access.');
      return null;
    }
  }
  print("location permission granted");

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print("position: $position");
    return position;
  } catch (e) {
    _showDialog(context, 'Error', 'Unable to get location.');
    return null;
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
