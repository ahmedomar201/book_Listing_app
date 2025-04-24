abstract class AppState {}

class Empty extends AppState {}

class GetWeatherLoading extends AppState {}

class GetWeatherSuccess extends AppState {}

class GetWeatherError extends AppState {
  final String error;
  GetWeatherError({
    required this.error,
  });
}

