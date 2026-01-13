import 'package:dio/dio.dart';
import '../../di/injector.dart';
import '../../services/logger_service.dart';

class LoggingInterceptor extends Interceptor {
  final _logger = sl<LoggerService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('➡️ ${options.method} ${options.path}');
    _logger.d('Headers: ${options.headers}');
    _logger.d('Data: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d('✅ ${response.statusCode} ${response.requestOptions.path}');
    _logger.d('Response: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('❌ ${err.requestOptions.path}', err.message, err.stackTrace);
    handler.next(err);
  }
}
