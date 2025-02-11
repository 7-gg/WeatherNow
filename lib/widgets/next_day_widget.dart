import 'package:flutter/material.dart';
import 'package:weathernow/helper/screen_size.dart';

class NextDayWidget extends StatelessWidget {
  final String iconPath;
  final String date;
  final String temperature;

  const NextDayWidget({
    Key? key,
    required this.iconPath,
    required this.date,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        margin: EdgeInsets.all(3),
        // decoration: BoxDecoration(color: Colors.yellow.shade200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            Image.asset(
              iconPath,
              width: ScreenSize.getWidth(context) * 0.14,
            ),
            SizedBox(height: 10),
            //date
            Text(
              '$date',
              style: TextStyle(fontSize: 11),
            ),
            SizedBox(height: 2),
            // temperature
            Text('$temperature')
          ],
        ),
      ),
    );
  }
}
