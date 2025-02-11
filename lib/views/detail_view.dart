import 'package:flutter/material.dart';
import 'package:weathernow/models/city_model.dart';

class DetailPage extends StatefulWidget {
  final City city;
  const DetailPage({super.key, required this.city});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.name),
      ),
      body: Column(
        children: [
          Text(widget.city.date),
          Text(widget.city.weatherDescription),
        ],
      ),
    );
  }
}
