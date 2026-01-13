import 'package:dio/dio.dart';
import '../../errors/app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    late AppException exception;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = NetworkException('Connection timeout');
        break;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = err.response?.data['message'] ?? 'Server error';

        if (statusCode == 401) {
          exception = AuthException(message, code: statusCode);
        } else {
          exception = AppException(message, code: statusCode);
        }
        break;

      case DioExceptionType.cancel:
        exception = AppException('Request cancelled');
        break;

      case DioExceptionType.unknown:
      default:
        exception = NetworkException('No internet connection');
        break;
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }
}
