// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// import 'package:geolocator/geolocator.dart';

// Future<void> requestPermission() async {
//   LocationPermission permission = await Geolocator.requestPermission();
//   if (permission == LocationPermission.denied) {
//   } else if (permission == LocationPermission.deniedForever) {
//     void _showAlertDialog(BuildContext context) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Activer la geolocalisation'),
//             content: Text('Ceci est un message d\'alerte !'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Fermer l'alerte
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   } else {
//     // Les permissions sont accordées
//   }
// }

// Future<Position> getUserLocation() async {
//   LocationPermission permission = await Geolocator.requestPermission();
//   if (permission == LocationPermission.deniedForever) {
//     return Future.error('Location permissions are permanently denied');
//   }
//   print('get localisation');
//   return await Geolocator.getCurrentPosition();
// }

// Future<String> getCityFromCoordinates(double latitude, double longitude) async {
//   List<Placemark> placemarks =
//       await placemarkFromCoordinates(latitude, longitude);
//   Placemark place = placemarks[0];
//   print("l'utilisateur se trouve :: ${place.locality}");
//   return place.locality ?? 'Ville inconnue';
// }

// Future<String> getUserCity() async {
//   try {
//     Position position = await getUserLocation();
//     return await getCityFromCoordinates(position.latitude, position.longitude);
//   } catch (e) {
//     return 'Erreur de localisation';
//   }
// }
