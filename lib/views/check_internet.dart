// ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/services/connectivity.dart';
import 'package:weathernow/views/no_internet.dart';
import 'package:weathernow/views/splashscreen.dart';

class CheckInternetPage extends ConsumerWidget {
  const CheckInternetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityStreamProvider);

    return connectivity.when(
      data: (connectivityResult) {
        if (connectivityResult == ConnectivityResult.none) {
          return NoInternetPage(); // Afficher la page de "Pas de connexion"
        } else {
          return SplashScreen(); // acces au home page
        }
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, stack) => Center(child: Text("Erreur de connectivité")),
    );
  }
}
