import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weathernow/components/message.dart';

void main() {
  testWidgets('MessageWidget displays the message and image correctly',
      (WidgetTester tester) async {
    // Arrange : Définir le message et le chemin de l'image
    const message = 'Hello, World!';
    const imagePath = 'assets/images/back.jpeg';
    // Chargez le widget MessageWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageWidget(
            message: message,
            imagePath: imagePath,
          ),
        ),
      ),
    );
    // Attendez que toutes les animations et timers soient terminés
    await tester.pumpAndSettle();

    // Assert : Vérifiez que le texte "Hello, World!" est affiché
    expect(find.text(message), findsOneWidget);

    // Assert : Vérifiez que l'image est affichée (recherche par taille, car l'image peut être un widget complexe)
    expect(find.byType(Container),
        findsOneWidget); // Vérifie qu'un container (qui contient l'image) est présent.

    // Assert : Vérifier que l'image est bien présente dans le widget
    final containerFinder = find.byType(Container);
    final container = tester.widget<Container>(containerFinder.first);
    final decoration = container.decoration as BoxDecoration;
    final image = decoration.image;

    expect(image?.image, isA<AssetImage>());
    expect((image?.image as AssetImage).assetName, imagePath);
  });
}
