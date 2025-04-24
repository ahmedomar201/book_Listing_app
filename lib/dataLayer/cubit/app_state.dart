abstract class AppState {}

class Empty extends AppState {}

class GetBooksLoading extends AppState {}

class GetBooksSuccess extends AppState {}

class GetBooksError extends AppState {
  final String error;
  GetBooksError({
    required this.error,
  });
}



class GetBooksSearchLoading extends AppState {}

class GetBooksSearchSuccess extends AppState {}

class GetBooksSearchError extends AppState {
  final String error;
  GetBooksSearchError({
    required this.error,
  });
}

class GetBooksPaginationSuccess  extends AppState {}