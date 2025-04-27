import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../core/error/exceptions.dart';
import '../local/cache_helper.dart';
import '../models/book_model.dart';
import '../remote/dio_helper.dart';

abstract class Repository {
  Future<Either<String, BookModel>> getBooks(int page);
  Future<Either<String, BookModel>> getBookSearch(String name, int page);
}

class RepoImplementation extends Repository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  RepoImplementation({required this.cacheHelper, required this.dioHelper});

  @override
  Future<Either<String, BookModel>> getBooks(int page) async {
    return basicErrorHandling<BookModel>(
      onSuccess: () async {
        var response = await dioHelper.get(url: "?page=$page");
        debugPrint('getBooks response =====> ${response.data}');
        await cacheHelper.put('books_page_$page', response.data);
        return BookModel.fromJson(response.data);
      },
      onServerError: (exception) async {
        debugPrint('Server error: ${exception.message}');
        final cachedData = await cacheHelper.get('books_page_$page');
        if (cachedData != null) {
          debugPrint('Loaded from cache for page $page');
          return Right(BookModel.fromJson(cachedData));
        }
        return Left(exception.message);
      },
    );
  }

  @override
  Future<Either<String, BookModel>> getBookSearch(String name, int page) async {
    final cacheKey = 'search_${name}_page_$page';
    return basicErrorHandling<BookModel>(
      onSuccess: () async {
        var response = await dioHelper.get(url: "?search=$name&page=$page");
        debugPrint('getBookSearch response =====> ${response.data}');
        await cacheHelper.put(cacheKey, response.data);
        debugPrint('CacheKey response =====> $cacheKey');
        return BookModel.fromJson(response.data);
      },
      onServerError: (exception) async {
        debugPrint('Server error: ${exception.message}');
        final cachedData = await cacheHelper.get(cacheKey);
        if (cachedData != null) {
          debugPrint('Loaded from cache for search: $name, page: $page');
          return Right(BookModel.fromJson(cachedData));
        }
        return Left(exception.message);
      },
    );
  }
}

Future<Either<String, T>> basicErrorHandling<T>({
  required Future<T> Function() onSuccess,
  Future<Either<String, T>> Function(ServerException exception)? onServerError,
  Future<Either<String, T>> Function(CacheException exception)? onCacheError,
  Future<Either<String, T>> Function(dynamic exception)? onOtherError,
}) async {
  try {
    final f = await onSuccess();
    return Right(f);
  } on ServerException catch (e, s) {
    debugPrint(s.toString());
    if (onServerError != null) {
      final f = await onServerError(e);
      return f;
    }
    return const Left('Server Error');
  } on CacheException catch (e) {
    debugPrint(e.toString());
    if (onCacheError != null) {
      final f = await onCacheError(e);
      return f;
    }
    return const Left('Cache Error');
  } catch (e, s) {
    debugPrint(s.toString());
    if (onOtherError != null) {
      final f = await onOtherError(e);
      return f;
    }
    return Left(e.toString());
  }
}
