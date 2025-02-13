import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/models/city.dart';

// Déclaration du provider
final detailProvider = StateProvider<City?>((ref) => null); // initialisé à null
