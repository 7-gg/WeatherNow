import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathernow/helpers/function.dart';
import 'package:weathernow/helpers/screen_size.dart';
import 'package:weathernow/providers/city_name.dart';
import 'package:weathernow/providers/detail.dart';
import 'package:weathernow/providers/weather.dart';
import 'package:weathernow/services/check_connexion.dart';
import 'package:weathernow/views/detail.dart';
import 'package:weathernow/components/message.dart';
import 'package:weathernow/components/next_day.dart';
import 'package:weathernow/components/today.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController searchController = TextEditingController();
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
    var cityName = ref.watch(cityNameProvider);
    final weatherAsync = ref.watch(weatherProvider(cityName!));
    //
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  const Color.fromARGB(255, 245, 208, 203)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
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
                      hintText: 'Check a city ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () =>
                            updateCityName(ref, searchController.text),
                      ),
                    ),
                  ),
                ),
              ),
              // affichage des données
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      !userConnected
                          ? MessageWidget(
                              message: "Oups! you are offline",
                              imagePath: 'assets/images/offline.png',
                            )
                          : weatherAsync.when(
                              data: (cityWeather) {
                                if (cityWeather.isEmpty) {
                                  return MessageWidget(
                                    message: "Oups! any data found",
                                    imagePath: 'assets/images/no_data.png',
                                  );
                                }
                                final today =
                                    cityWeather.first; // La météo du jour
                                final nextDays = cityWeather
                                    .sublist(1); // Les jours suivants
                                //  ..
                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Carte pour la météo du jour
                                      TodayWidget(
                                        cityName: cityName,
                                        description: today.weatherDescription,
                                        temperature:
                                            today.temperature.toString(),
                                        date: today.date,
                                        iconPath: weatherDescriptionIcon(
                                            today.weatherDescription),
                                        cloudiness: today.cloudiness.toString(),
                                        humidity: today.humidity.toString(),
                                        windSpeed: today.windSpeed.toString(),
                                      ),
                                      // les jours suivants
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Next days",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        height: ScreenSize.getHeight(context) *
                                            0.16,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: nextDays.length,
                                          itemBuilder: (context, index) {
                                            final day = cityWeather[index];

                                            return Consumer(
                                              builder: (context, watch, child) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    // Met à jour le provider avec l'objet City sélectionné
                                                    ref
                                                        .read(detailProvider
                                                            .notifier)
                                                        .state = day;
                                                    // appeler la route
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailPage(),
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    child: NextDayWidget(
                                                        iconPath:
                                                            weatherDescriptionIcon(day
                                                                .weatherDescription),
                                                        date: day.date,
                                                        temperature:
                                                            "${day.temperature}°C"),
                                                  ), // Card(
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              loading: () => Center(
                                child: SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
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
