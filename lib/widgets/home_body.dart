import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/common/common_state.dart';
import 'package:weatherapp/cubit/ourly_weather_cubit.dart';
import 'package:weatherapp/cubit/weather_cubit.dart';
import 'package:weatherapp/model/current_weather_model.dart';
import 'package:weatherapp/model/hourly_weather_model.dart';
import 'package:weatherapp/widgets/screens/hourly_weather_screen.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final showLoading = false;
  final datetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double fontSize = 7.3 * pixelRatio;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          DateFormat.yMMMd().format(datetime),
          style: TextStyle(
            fontSize: fontSize * 1.2,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
          ),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.sunny_snowing,
            ),
            color: Colors.white,
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoadingState) {
            return Container(
              height: size.height,
              width: size.width,
              color: Colors.indigo,
              child: const Center(
                  child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              )),
            );
          } else if (state is CommonSucessState) {
            WeatherModel weatherdata = state.data;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4 * pixelRatio),
                      padding: EdgeInsets.only(
                          left: size.width * 0.01,
                          right: size.width * 0.01,
                          top: size.height * 0.02,
                          bottom: 7 * pixelRatio),
                      height: size.height * 0.70,
                      width: size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 158, 93, 228)
                                  .withOpacity(0.5),
                              const Color.fromARGB(255, 74, 161, 238)
                                  .withOpacity(0.5),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0.2, 0.70]),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
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
                            height: size.height * 0.06,
                          ),
                          // Text(
                          //   DateFormat.yMMMd().format(
                          //     DateTime.fromMillisecondsSinceEpoch(
                          //       weatherdata.dt * 1000,
                          //     ),
                          //   ),
                          //   style: TextStyle(
                          //     fontSize: fontSize,
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.w300,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.04,
                          // ),
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
                                      fontSize: fontSize,
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
                              fontSize: 25 * pixelRatio,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 20 * pixelRatio,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
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
                                Column(
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
                                Column(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SizedBox(
                    height: size.height * 0.20,

                    // 6 days weather data  List view
                    child: BlocBuilder<OurlyWeatherCubit, CommonState>(
                      builder: (context, state) {
                        if (state is CommonSucessState) {
                          HourlyWeatherModel hourweatherdata = state.data;
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: hourweatherdata.list.length > 6
                                  ? 6
                                  : hourweatherdata.list.length,
                              itemBuilder: (context, index) {
                                return HourlySCreen(
                                  item: index,
                                  hourlyWeatherModel: hourweatherdata,
                                );
                              });
                        } else if (state is CommonErrorState) {
                          return Text(state.message);
                        } else {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5 * pixelRatio,
                      vertical: 3 * pixelRatio,
                    ),
                    child: Divider(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5 * pixelRatio),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Next 7 days",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "View Details",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
