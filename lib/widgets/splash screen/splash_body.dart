import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weatherapp/widgets/home_screen.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  get type => null;

  @override
  void initState() {
    Timer.periodic(
        const Duration(
          seconds: 3,
        ), (timer) {
      Navigator.of(context).push(
        PageTransition(
            child: const HomeScreen(), type: PageTransitionType.fade),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Image.asset(
              "assets/weather/splash.png",
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.30,
                  bottom: MediaQuery.of(context).size.height * 0.03),
              child: const Text(
                "Developed By: Suman Ghimire",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
