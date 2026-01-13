class AppException implements Exception {
  final String message;
  final int? code;

  AppException(this.message, {this.code});

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

class NetworkException extends AppException {
  NetworkException(super.message, {super.code});
}

class AuthException extends AppException {
  AuthException(super.message, {super.code});
}
