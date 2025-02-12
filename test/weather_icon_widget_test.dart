import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weathernow/Components/weather_icon.dart';

void main() {
  testWidgets('WeatherIconWidget displays the correct icon, value, and label',
      (WidgetTester tester) async {
    // Arrange: Créez un widget de test
    const iconPath = 'assets/sun_icon.png';
    const value = '23°C';
    const label = 'Temperature';

    // Chargez le widget WeatherIconWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WeatherIconWidget(
            iconPath: iconPath,
            value: value,
            label: label,
          ),
        ),
      ),
    );

    // Assert: Vérifiez que l'icône est affichée
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Image),
        findsOneWidget); // Vérifie si une image est affichée

    // Vérifiez que la valeur "23°C" est affichée
    expect(find.text(value), findsOneWidget);

    // Vérifiez que le label "Temperature" est affiché
    expect(find.text(label), findsOneWidget);
  });
}
