import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/common/common_state.dart';
import 'package:weatherapp/cubit/weather_cubit.dart';
import 'package:weatherapp/model/current_weather_model.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final showLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double fontSize = 7.6 * pixelRatio;
    return Scaffold(
      body: BlocBuilder<WeatherCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoadingState) {
            return Container(
              height: size.height,
              width: size.width,
              color: Colors.blueAccent,
              child: const Center(
                  child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              )),
            );
          } else if (state is CommonSucessState) {
            WeatherModel weatherdata = state.data;

            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.005),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: size.width * 0.01,
                          right: size.width * 0.01,
                          top: size.height * 0.06,
                          bottom: 15 * pixelRatio),
                      height: size.height * 0.74,
                      width: size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 158, 93, 228),
                              Color.fromARGB(255, 74, 161, 238),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.2, 0.70]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            weatherdata.name,
                            style: TextStyle(
                              fontSize: 18 * pixelRatio,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Text(
                            DateFormat.yMMMd().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                weatherdata.dt * 1000,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: size.width * 0.02,
                                right: size.width * 0.02),
                            padding: EdgeInsets.only(
                                left: size.width * 0.02,
                                right: size.width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    '↑ ${weatherdata.main.tempMax}°',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7.7 * pixelRatio,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Image.asset(
                                  "assets/weather/${weatherdata.weather[0].icon}.png",
                                  fit: BoxFit.contain,
                                  height: size.height * 0.1,
                                ),
                                const Spacer(),
                                Expanded(
                                  child: Text(
                                    '↓ ${weatherdata.main.tempMin}°',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            weatherdata.weather[0].main,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Text(
                            "${weatherdata.main.temp}°C",
                            style: TextStyle(
                              fontSize: 20 * pixelRatio,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 15 * pixelRatio,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/weather/clouds.png',
                                      fit: BoxFit.contain,
                                      width: size.width * 0.11,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "${weatherdata.clouds.all}%",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Clouds",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/weather/humidity.png',
                                      width: size.width * 0.11,
                                      color: Colors.white54,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "${weatherdata.main.humidity}%",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Humidity",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Image.asset('assets/weather/windspeed.png',
                                        width: size.width * 0.11,
                                        color: Colors.white54),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "${weatherdata.wind.speed} km/hr",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Wind",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Gust",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "${weatherdata.wind.gust} km/h",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Wind",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "${weatherdata.wind.speed}km/h",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Deg",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "${weatherdata.wind.deg}",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Pressure",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                height: fontSize * 0.005,
                              ),
                              Text(
                                "${weatherdata.main.pressure} hpa",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Sunrise",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Text(
                                "${DateFormat.Hm().format(DateTime(weatherdata.sys.sunrise))} AM",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Sunset",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Text(
                                "${DateFormat.Hm().format(
                                  DateTime(weatherdata.sys.sunset),
                                )} PM",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CommonErrorState) {
            return Center(
              child: Text(
                "Unable access your location !",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400),
              ),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
