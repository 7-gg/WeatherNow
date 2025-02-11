import 'package:flutter/material.dart';

class WeatherIconWidget extends StatelessWidget {
  final String iconPath;
  final String value;
  final String label;

  const WeatherIconWidget({
    Key? key,
    required this.iconPath,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade200,
          radius: 24,
          child: Image.asset(
            iconPath,
            width: 28,
            height: 28,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
