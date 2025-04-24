class ServerException implements Exception {
  final int code;
  final String message;

  ServerException({
    required this.code,
    required this.message,
  });

  @override
  String toString() => 'ServerException(code: $code, message: $message)';
}

class CacheException implements Exception {
  final dynamic error;

  CacheException(this.error);

  @override
  String toString() => 'CacheException(error: $error)';
}
