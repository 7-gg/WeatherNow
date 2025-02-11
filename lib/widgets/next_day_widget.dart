import 'package:flutter/material.dart';
import 'package:weathernow/helper/screen_size.dart';

class NextDayWidget extends StatelessWidget {
  final String iconPath;
  final String date;
  final String temperature;

  const NextDayWidget({
    super.key,
    required this.iconPath,
    required this.date,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.4,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, const Color.fromARGB(255, 245, 208, 203)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            Image.asset(
              iconPath,
              width: ScreenSize.getWidth(context) * 0.14,
              height: 45,
            ),
            SizedBox(height: 10),
            //date
            Text(
              date,
              style: TextStyle(fontSize: 11),
            ),
            SizedBox(height: 2),
            // temperature
            Text(temperature)
          ],
        ),
      ),
    );
  }
}
