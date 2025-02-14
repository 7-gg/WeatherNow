import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/helpers/screen_size.dart';
import 'package:weathernow/views/home.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> logoSizeAnimation; // Animation for logo size

  @override
  void initState() {
    super.initState();

    // Animation Controller for fading and resizing logo
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.3).animate(animationController);
    logoSizeAnimation = Tween<double>(begin: 150.0, end: 600.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    animationController.repeat(reverse: true); // Fading animation

    // After 4 seconds, navigate to HomePage
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
    // The logo size is now managed via the animation
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background color
          ColoredBox(
            color: Colors.white38,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Logo
              AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: logoSizeAnimation.value, // Animated size
                    height: logoSizeAnimation.value,
                    child: FadeTransition(
                      opacity: fadeAnimation, // Fading effect
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  );
                },
              ),
              SizedBox(height: ScreenSize.getHeight(context) * 0.3),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  "WeatherNow",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: const Text(
                    "The weather is at your fingertips",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
