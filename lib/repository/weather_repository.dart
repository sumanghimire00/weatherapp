import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weatherapp/common/string.dart';
import 'package:weatherapp/model/current_weather_model.dart';

class WeatherRepository {
  final Dio dio;

  WeatherRepository({required this.dio});

  Future<Either<String, WeatherModel>> fetchWeatherData() async {
    try {
      // LocationService locationService = LocationService();
      // Position position = await locationService.getLocation();

      final res = await dio.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=b2e54ed191ad542161d3d14f1a280277&units=metric");
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
