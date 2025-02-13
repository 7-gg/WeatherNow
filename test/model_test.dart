// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:weathernow/models/city.dart';

void main() {
  test('City model should correctly store attributes', () {
    // Arrange
    final city = City(
        date: '2025-02-12',
        name: 'Paris',
        temperature: 23.2,
        windSpeed: 21.0,
        weatherDescription: 'wind',
        humidity: 12,
        cloudiness: 17,
        visibility: 10);

    // Act & Assert
    expect(city.name, 'Paris');
    expect(city.temperature, 23.2);
    expect(city.humidity, 12);
  });
}
