import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/common/string.dart';
import 'package:weatherapp/model/current_weather_model.dart';
import 'package:weatherapp/model/get_location.dart';
import 'package:weatherapp/model/hourly_weather_model.dart';

class WeatherRepository {
  final Dio dio;

  WeatherRepository({required this.dio});

  Future<Either<String, WeatherModel>> fetchWeatherData() async {
    try {
      LocationService locationService = LocationService();
      Position position = await locationService.getLocation();

      final res = await dio.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric");
      final data = WeatherModel.fromJson(res.data);
      return Right(data);
    } on DioException catch (e) {
      return Left(
          e.response?.data["message"] ?? "Unable to fetch weatherData!!");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, HourlyWeatherModel>> ourlyWeatherModelData() async {
    try {
      LocationService locationService = LocationService();
      Position position = await locationService.getLocation();
      final res = await dio.get(
          "https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric");
      final hourlyWeatherModel = HourlyWeatherModel.fromJson(res.data);
      return Right(hourlyWeatherModel);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable fetch weather data!!");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
