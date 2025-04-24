import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/constansts.dart';
import '../../core/utils/images.dart';
import '../networks/models/weather_model.dart';
import '../networks/repository/repository.dart';
import 'app_state.dart';

AppBloc get cubit => AppBloc.get(navigatorKey.currentContext!);

class AppBloc extends Cubit<AppState> {
  final Repository repo;

  AppBloc({required Repository repository}) : repo = repository, super(Empty());

  static AppBloc get(context) => BlocProvider.of(context);

  TextEditingController cityController = TextEditingController();
  WeatherModel? weather;
  void getWeather(context) async {
    emit(GetWeatherLoading());

    final result = await repo.getWeather(cityController.text);

    result.fold(
      (failure) {
        debugPrint('-----failure------$failure');
        emit(GetWeatherError(error: failure));
      },
      (data) {
        weather = data;
        emit(GetWeatherSuccess());
      },
    );
  }

  Image getWeatherIcon(double temp) {
    if (temp > 25) {
      return Image.asset(ImagesConstant.sunny, width: 50, height: 50);
    } else if (temp >= 15 && temp <= 25) {
      return Image.asset(ImagesConstant.cloudy, width: 50, height: 50);
    } else {
      return Image.asset(ImagesConstant.snow, width: 50, height: 50);
    }
  }
}
