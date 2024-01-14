import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/hourly_weather_model.dart';

class HourlySCreen extends StatelessWidget {
  const HourlySCreen(
      {super.key, required this.item, required this.hourlyWeatherModel});
  final HourlyWeatherModel hourlyWeatherModel;
  final int item;

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    final double fontSize = 7 * pixelRatio;
    var datetime = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(
        hourlyWeatherModel.list[item].dt * 1000));
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            datetime,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
          Image(
            image: AssetImage(
              "assets/weather/${hourlyWeatherModel.list[item].weather[0].icon}.png",
            ),
            width: MediaQuery.of(context).size.width * 0.18,
          ),
          Text(
            "${hourlyWeatherModel.list[item].main.temp.toInt()}",
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
