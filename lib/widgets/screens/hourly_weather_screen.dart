import 'package:flutter/material.dart';

class HourlySCreen extends StatelessWidget {
  const HourlySCreen({super.key, required this.item});
  final int item;
  @override
  Widget build(BuildContext context) {
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
            "${item + 1} AM",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Image(
            image: const AssetImage(
              "assets/weather/04n.png",
            ),
            width: MediaQuery.of(context).size.width * 0.18,
          ),
          const Text(
            "34°",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
