import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/helper/screen_size.dart';
import 'package:weathernow/providers/weather_provider.dart';
import 'package:weathernow/services/check_connexion.dart';
import 'package:weathernow/views/detail_view.dart';
import 'package:weathernow/widgets/message_widget.dart';
import 'package:weathernow/widgets/today_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String city = 'Lomé';
  bool userConnected = false;
  String iconPath = "";

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void weatherDescription(String description) {
    print("description = $description");
    if (description.toLowerCase().contains("cloud") ||
        description.toLowerCase().contains("nuageux")) {
      setState(() {
        iconPath = 'assets/cloud_icon.png'; // Icône pour un ciel nuageux
      });
    } else if (description.toLowerCase().contains("storm") ||
        description.toLowerCase().contains("orage")) {
      setState(() {
        iconPath = 'assets/storm_icon.png'; // Icône pour un ciel orageux
      });
    } else if (description.toLowerCase().contains("sun") ||
        description.toLowerCase().contains("ensoleillé")) {
      setState(() {
        iconPath = 'assets/sun_icon.png'; // Icône pour un ciel ensoleillé
      });
    } else if (description.toLowerCase().contains("rain") ||
        description.toLowerCase().contains("pluie")) {
      setState(() {
        iconPath = 'assets/rain_icon.png'; // Icône pour un ciel pluvieux
      });
    } else {
      setState(() {
        iconPath = 'assets/sun_icon.png'; // Icône par défaut
      });
    }
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
              // affichage des données
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      !userConnected
                          ? MessageWidget(
                              message:
                                  "Oups! Vous n'êtes pas connecté à internet",
                              imagePath: 'assets/offline.jpg',
                            )
                          : weatherAsync.when(
                              data: (cityWeather) {
                                if (cityWeather.isEmpty) {
                                  return MessageWidget(
                                    message: "Oups! Aucune donnée disponible",
                                    imagePath: 'assets/no_data.png',
                                  );
                                }
                                final today =
                                    cityWeather.first; // La météo du jour
                                final nextDays = cityWeather
                                    .sublist(1); // Les jours suivants
                                // ..
                                setState(() {
                                  weatherDescription(today.weatherDescription);
                                  print('icon retenu $iconPath');
                                });
                                //  ..
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Carte pour la météo du jour
                                    TodayWidget(
                                        cityName: city,
                                        description: today.weatherDescription,
                                        temperature:
                                            today.temperature.toString(),
                                        date: today.date,
                                        iconPath: iconPath,
                                        cloudiness: today.cloudiness.toString(),
                                        humidity: today.humidity.toString(),
                                        windSpeed: today.windSpeed.toString()),
                                    // les jours suivants

                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Prochains jours",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(height: 20),
                                    SizedBox(
                                      height:
                                          ScreenSize.getHeight(context) * 0.16,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: cityWeather.length,
                                        itemBuilder: (context, index) {
                                          final day = cityWeather[index];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(city: day),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  Text(day.date),
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
