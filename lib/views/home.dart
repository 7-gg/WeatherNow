// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weathernow/helpers/function.dart';
import 'package:weathernow/helpers/screen_size.dart';
import 'package:weathernow/models/location.dart';
import 'package:weathernow/providers/detail.dart';
import 'package:weathernow/providers/home.dart';
import 'package:weathernow/services/location.dart';
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

  @override
  Widget build(BuildContext context) {
    var cityName = ref.watch(cityNameProvider);
    final weatherState = ref.watch(weatherProvider);
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
              // Search area
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
                  child: Row(
                    children: [
                      // Search bar
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Check a city ...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                // Check if the search field is empty
                                if (searchController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please enter a city name'),
                                    ),
                                  );
                                } else {
                                  // Activate the loader
                                  ref.read(loaderProvider.notifier).state =
                                      true;
                                  // Update cityName
                                  ref.read(cityNameProvider.notifier).state =
                                      searchController.text;
                                  // Call fetchWeather with the new city
                                  ref
                                      .read(weatherProvider.notifier)
                                      .fetchWeather()
                                      .then((value) {
                                    // Deactivate the loader
                                    ref.read(loaderProvider.notifier).state =
                                        false;
                                  });
                                  // Clear the search bar
                                  searchController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // API call based on location
                      IconButton(
                        onPressed: () async {
                          // Activate the loader
                          ref.read(loaderProvider.notifier).state = true;

                          // Clear the city name
                          ref.read(cityNameProvider.notifier).state = "";
                          // ..
                          await getCurrentLocation(context, ref).then((value) {
                            if (value != null) {
                              // Update the location in Riverpod
                              ref.read(locationProvider.notifier).state =
                                  Location(
                                      latitude: value.latitude,
                                      longitude: value.longitude);
                              // Call fetchWeather with the new location
                              ref
                                  .read(weatherProvider.notifier)
                                  .fetchWeather()
                                  .then((value) {
                                // Deactivate the loader
                                ref.read(loaderProvider.notifier).state = false;
                              });
                            } else {
                              // Deactivate the loader
                              ref.read(loaderProvider.notifier).state = false;
                              // Show an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Error retrieving current location'),
                                ),
                              );
                            }
                          });
                        },
                        icon: Icon(
                          Icons.location_on,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Display data
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: cityName.isEmpty &&
                          ref.read(locationProvider.notifier).state == null
                      ? welcome()
                      : ref.read(loaderProvider.notifier).state == true
                          ? loading()
                          : Column(
                              children: [
                                weatherState.when(
                                  data: (cityWeather) {
                                    if (cityWeather.isEmpty) {
                                      return MessageWidget(
                                        message: "Oups! any data found",
                                        imagePath: 'assets/images/no_data.png',
                                      );
                                    }
                                    final today =
                                        cityWeather.first; // Today's weather
                                    final nextDays = cityWeather
                                        .sublist(1); // Following days
                                    var lat = ref
                                        .read(locationProvider.notifier)
                                        .state!
                                        .latitude;
                                    var long = ref
                                        .read(locationProvider.notifier)
                                        .state!
                                        .longitude;
                                    //  ..
                                    return Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Card for today's weather
                                          TodayWidget(
                                            cityName: cityName.isEmpty
                                                ? 'Latitude : $lat\n Longitude : $long'
                                                : cityName,
                                            description:
                                                today.weatherDescription,
                                            temperature:
                                                today.temperature.toString(),
                                            date: today.date,
                                            iconPath: weatherDescriptionIcon(
                                                today.weatherDescription),
                                            cloudiness:
                                                today.cloudiness.toString(),
                                            humidity: today.humidity.toString(),
                                            windSpeed:
                                                today.windSpeed.toString(),
                                          ),
                                          // Text
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
                                          // List of following days
                                          SizedBox(
                                            height:
                                                ScreenSize.getHeight(context) *
                                                    0.16,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: nextDays.length,
                                              itemBuilder: (context, index) {
                                                final day = cityWeather[index];

                                                return Consumer(
                                                  builder:
                                                      (context, watch, child) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        // Update the provider with the selected City object
                                                        ref
                                                            .read(detailProvider
                                                                .notifier)
                                                            .state = day;
                                                        // Navigate to the detail page
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
                                                            const EdgeInsets
                                                                .all(3),
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
                                  loading: () => loading(),
                                  error: (err, stack) => MessageWidget(
                                    message: "Error: ${err.toString()}",
                                    imagePath: 'assets/images/no_data.png',
                                  ),
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

  Widget loading() {
    return Center(
      child: SizedBox(
        height: 35,
        width: 35,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget welcome() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/city.svg',
            width: ScreenSize.getWidth(context) * 0.2, // Width
            height: ScreenSize.getHeight(context) * 0.3, // Height
          )
              .animate()
              .fadeIn(duration: 1.seconds) // Fade-in animation
              .moveY(begin: -50, end: 0, duration: 1.seconds),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Welcome to WeatherNow, please enter a city name to get the weather",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Or click on the location icon to get the weather of your current location",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
    //
  }
}
