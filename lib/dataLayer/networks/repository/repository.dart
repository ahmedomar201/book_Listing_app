import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../core/error/exceptions.dart';
import '../models/book_model.dart';
import '../remote/dio_helper.dart';

abstract class Repository {
  Future<Either<String, BookModel>> getBooks(int page);

  Future<Either<String, BookModel>> getBookSearch(String name,int page);
}

class RepoImplementation extends Repository {
  final DioHelper dioHelper;

  RepoImplementation({required this.dioHelper});

  @override
  Future<Either<String, BookModel>> getBooks(int page) async {
    return basicErrorHandling<BookModel>(
      onSuccess: () async {
        var response = await dioHelper.get(url: "?page=$page");
        debugPrint('getBooks reponse =====> ${response.data}');
        return BookModel.fromJson(response.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }
  @override
  Future<Either<String, BookModel>> getBookSearch(String name,int page) async {
    return basicErrorHandling<BookModel>(
      onSuccess: () async {
        var response = await dioHelper.get(url: "?search=$name&page=$page");
        debugPrint('getBookSearch reponse =====> ${response.data}');
        return BookModel.fromJson(response.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }
}

Future<Either<String, T>> basicErrorHandling<T>({
  required Future<T> Function() onSuccess,
  Future<String> Function(ServerException exception)? onServerError,
  Future<String> Function(CacheException exception)? onCacheError,
  Future<String> Function(dynamic exception)? onOtherError,
}) async {
  try {
    final f = await onSuccess();
    return Right(f);
  } on ServerException catch (e, s) {
    debugPrint(s.toString());
    if (onServerError != null) {
      final f = await onServerError(e);
      return Left(f);
    }
    return const Left('Server Error');
  } on CacheException catch (e) {
    debugPrint(e.toString());
    if (onCacheError != null) {
      final f = await onCacheError(e);
      return Left(f);
    }
    return const Left('Cache Error');
  } catch (e, s) {
    debugPrint(s.toString());
    if (onOtherError != null) {
      final f = await onOtherError(e);
      return Left(f);
    }
    return Left(e.toString());
  }
}
