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
      elevation: 0.6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          gradient: LinearGradient(
            colors: [Colors.white, const Color.fromARGB(255, 245, 208, 203)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(2),
        width: 75,
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
              style: TextStyle(fontSize: 11, color: Colors.black),
            ),
            SizedBox(height: 5),
            // temperature
            Text(
              temperature,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
