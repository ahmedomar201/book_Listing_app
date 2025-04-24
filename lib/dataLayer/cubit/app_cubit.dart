import 'package:book_list_app/dataLayer/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/constansts.dart';
import '../networks/models/book_model.dart';
import '../networks/repository/repository.dart';

AppBloc get cubit => AppBloc.get(navigatorKey.currentContext!);

class AppBloc extends Cubit<AppState> {
  final Repository repo;

  AppBloc({required Repository repository}) : repo = repository, super(Empty());

  static AppBloc get(context) => BlocProvider.of(context);

  TextEditingController nameBookController = TextEditingController();
  BookModel? books;
  int page = 1;
  bool isLoadingMore = false;
bool hasMoreData = true;
List<Results> allBooks = [];



void getBooks({bool isPagination = false}) async {
  if (isPagination) {
    if (isLoadingMore || !hasMoreData) return;
    isLoadingMore = true;
  } else {
    emit(GetBooksLoading());
    allBooks.clear();
    page = 1;
    hasMoreData = true;
  }

  final result = await repo.getBooks(page);

  result.fold(
    (failure) {
      if (isPagination) {
        isLoadingMore = false;
      } else {
        emit(GetBooksError(error: failure));
      }
    },
    (data) {
      if (data.results != null && data.results!.isNotEmpty) {
        allBooks.addAll(data.results!);
        page++;
      } else {
        hasMoreData = false;
      }

      books = data;

      if (isPagination) {
        isLoadingMore = false;
        emit(GetBooksPaginationSuccess());
      } else {
        emit(GetBooksSuccess());
      }
    },
  );
}


  void getBooksSearch() async {
    emit(GetBooksSearchLoading());

    final result = await repo.getBookSearch(nameBookController.text);

    result.fold(
      (failure) {
        debugPrint('-----failure------$failure');
        emit(GetBooksSearchError(error: failure));
      },
      (data) {
        books = data;
        emit(GetBooksSearchSuccess());
      },
    );
  }
}
