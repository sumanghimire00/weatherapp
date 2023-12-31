import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/common/common_state.dart';
import 'package:weatherapp/model/current_weather_model.dart';
import 'package:weatherapp/repository/weather_repository.dart';

class WeatherCubit extends Cubit<CommonState> {
  WeatherCubit({required this.weatherRepository}) : super(CommonInitialState());

  final WeatherRepository weatherRepository;

  fetchWeather() async {
    emit(CommonLoadingState());
    final res = await weatherRepository.fetchWeatherData();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSucessState<WeatherModel>(data: data)),
    );
  }
}
