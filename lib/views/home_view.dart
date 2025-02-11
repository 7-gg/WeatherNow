import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/providers/weather_provider.dart';
import 'package:weathernow/services/check_connexion.dart';
import 'package:weathernow/views/detail_view.dart';
import 'package:weathernow/widgets/message_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String city = 'Lomé';
  bool userConnected = false;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void checkConnection() async {
    bool isConnected = await checkConnexion();
    setState(() {
      userConnected = isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(weatherProvider(city));
    //
    return Scaffold(
      body: Stack(
        children: [
          ColoredBox(color: Colors.white10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Barre de recherche
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 15),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Rechercher une ville ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            city = searchController.text;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              !userConnected
                  ? MessageWidget(
                      message: "Oups! Vous n'êtes pas connecté à internet",
                      imagePath: 'assets/offline.jpg',
                    )
                  : SingleChildScrollView(
                      child: weatherAsync.when(
                        data: (cityWeather) {
                          if (cityWeather.isEmpty) {
                            return MessageWidget(
                              message: "Oups! Aucune donnée disponible",
                              imagePath: 'assets/no_data.jpg',
                            );
                          }
                          final today = cityWeather.first; // La météo du jour
                          final nextDays =
                              cityWeather.sublist(1); // Les jours suivants

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Carte pour la météo du jour
                              Card(child: Text(today.weatherDescription)),
                              Text("A venir",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 20),
                              ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: cityWeather.length,
                                itemBuilder: (context, index) {
                                  final day = cityWeather[index];
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPage(city: day),
                                          ),
                                        );
                                      },
                                      title: Text(day.date),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Température: ${day.temperature}°C"),
                                          // Text("Humidité: ${day.humidity}%"),
                                          // Text("Conditions: ${day.weatherDescription}"),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                        loading: () => SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            Text("Erreur: ${err.toString()}"),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
