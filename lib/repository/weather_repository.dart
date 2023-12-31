import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/common/string.dart';
import 'package:weatherapp/model/current_weather_model.dart';
import 'package:weatherapp/model/get_location.dart';

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
}
