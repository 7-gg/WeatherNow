import 'package:http/http.dart' as http;

Future<bool> checkConnexion() async {
  try {
    // Envoie une requête GET vers www.google.com
    final response = await http.get(Uri.parse('https://www.google.com'));

    // Vérifie si la réponse est correcte (status code 200)
    if (response.statusCode == 200) {
      // Si la réponse est OK, cela signifie que la connexion est active
      return true;
    } else {
      // Si la réponse n'est pas OK, la connexion a échoué
      return false;
    }
  } catch (e) {
    // Si une exception se produit (pas de connexion par exemple), retourner false
    print('Erreur de connexion: $e');
    return false;
  }
}
