import 'package:dio/dio.dart';
import '../../di/injector.dart';
import '../../services/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final _storage = sl<SecureStorageService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
