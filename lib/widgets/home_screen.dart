import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubit/hourly_weather_cubit.dart';
import 'package:weatherapp/cubit/weather_cubit.dart';
import 'package:weatherapp/repository/weather_repository.dart';
import 'package:weatherapp/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              WeatherCubit(weatherRepository: context.read<WeatherRepository>())
                ..fetchWeather(),
        ),
        BlocProvider(
          create: (context) => HourlyWeatherCubit(
              weatherRepository: context.read<WeatherRepository>())
            ..fetchWeather(),
        ),
      ],
      child: const HomeBody(),
    );
  }
}
