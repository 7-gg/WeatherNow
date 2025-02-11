import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/providers/weather_provider.dart';
import 'package:weathernow/views/detail_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String city = 'Lomé';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(weatherProvider(city));
    //
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher...',
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
          SizedBox(height: 20),
          weatherAsync.when(
            data: (cityWeather) {
              if (cityWeather.isEmpty) {
                return Center(child: Text("Aucune donnée disponible"));
              }
              final today = cityWeather.first; // La météo du jour
              final nextDays = cityWeather.sublist(1); // Les jours suivants

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Carte pour la météo du jour
                  Card(child: Text(today.weatherDescription)),
                  Text("A venir",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                builder: (context) => DetailPage(city: day),
                              ),
                            );
                          },
                          title: Text(day.date),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Température: ${day.temperature}°C"),
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
                height: 25, width: 25, child: CircularProgressIndicator()),
            error: (err, stack) => Text("Erreur: ${err.toString()}"),
          )
        ],
      ),
    );
  }
}
