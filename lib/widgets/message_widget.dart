import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MessageWidget extends StatelessWidget {
  final String message; // Message à afficher
  final String imagePath; // Chemin de l'image à afficher

  // Constructeur
  const MessageWidget({
    super.key,
    required this.message,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Texte animé
            Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
                .animate()
                .fadeIn(duration: 1.seconds) // Animation d'apparition
                .moveY(begin: -50, end: 0, duration: 1.seconds),

            // Image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath), // Image provenant de l'asset
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
