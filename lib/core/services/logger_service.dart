import 'package:logger/logger.dart';

class LoggerService {
  final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  void d(String message) => _logger.d(message);
  void e(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
