import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weathernow/views/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double logoSize = 100; // Taille initiale du logo
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation de l'agrandissement du logo
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        logoSize = 200; // Augmenter la taille du logo
      });
    });

    // Animation de clignotement
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.3).animate(animationController);

    animationController.repeat(reverse: true); // Clignotement infini

    // Passer à la page d'accueil après 4 secondes
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image de fond
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animation du logo
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: logoSize,
                height: logoSize,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child:
                      Image.asset('assets/logo.png'), // Remplace par ton logo
                ),
              ),
              const SizedBox(height: 20),
              // Branding
              const Text(
                "WeatherNow,",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "prepared for any eventuality",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
