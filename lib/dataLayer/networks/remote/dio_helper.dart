import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constansts.dart';
import '../../../core/error/exceptions.dart';

abstract class DioHelper {
  Future<dynamic> get({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    dynamic headers,
    String? token,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  });
}

class DioImpl extends DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: apiUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
    ),
  );

  @override
  Future get({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    dynamic headers,
    String? token,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = timeOut;
    }
    if (headers != null) {
      dio.options.headers = headers;
    }

    if (base != null) {
      dio.options.baseUrl = base;
    } else {
      dio.options.baseUrl = apiUrl;
    }

    dio.options.headers = {
      // if (isMultipart) 'Content-Type': 'multipart/form-data',
      // if (!isMultipart) 'Content-Type': 'application/json',
      // if (!isMultipart) 'Accept': 'application/json',
      if (token != null) 'Authorization': "Bearer $token",
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrint('URL => ${dio.options.baseUrl + url}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    var respone = await request(
      () async => await dio.get(
        url,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
    // debugPrint('respone => $respone');

    return respone;
  }
}


extension on DioHelper {
  Future request(Future<Response> Function() request) async {
    try {
      final r = await request.call();
      return r;
    } on DioException catch (e) {
      debugPrint("Error Message => ${e.message}");
      debugPrint("Error => ${e.error.toString()}");

      if (e.response != null) {
        debugPrint("Error Response => ${e.response}");
        debugPrint("Error Response Message => ${e.response!.statusMessage}");
        debugPrint("Error Response Status Code => ${e.response!.statusCode}");
        debugPrint("Error Response Data => ${e.response!.data}");

        String errorMessage;
        if (e.response!.data is Map) {
          errorMessage = e.response!.data['errors'] ??
              e.response!.data['message'] ??
              e.response!.statusMessage;
        } else {
          errorMessage = 'An unexpected error occurred';
        }

        throw ServerException(
          code: e.response!.statusCode!,
          message: errorMessage,
        );
      } else {
        throw ServerException(
          code: 500,
          message: e.message ?? 'An unexpected error occurred',
        );
      }
    } catch (e) {
      // Handle any other unexpected errors
      debugPrint('Unknown Exception: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}