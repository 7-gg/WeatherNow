import 'package:flutter_riverpod/flutter_riverpod.dart';

final cityNameProvider =
    StateProvider<String?>((ref) => "Lomé"); // initialisé à null

void updateCityName(WidgetRef ref, String newName) {
  ref.read(cityNameProvider.notifier).state = newName;
}

void resetCityName(WidgetRef ref) {
  ref.read(cityNameProvider.notifier).state = null;
}
