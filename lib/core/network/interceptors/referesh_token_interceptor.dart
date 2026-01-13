import 'package:dio/dio.dart';
import '../../di/injector.dart';
import '../../../features/auth/data/auth_repository.dart';

class RefreshTokenInterceptor extends Interceptor {
  final _authRepository = sl<AuthRepository>();
  final Dio _dio = sl<Dio>();

  bool _isRefreshing = false;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          final tokens = await _authRepository.refreshToken();

          _isRefreshing = false;

          // retry original request
          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] =
              'Bearer ${tokens.accessToken}';

          final response = await _dio.fetch(requestOptions);
          return handler.resolve(response);
        } catch (_) {
          _isRefreshing = false;
          await _authRepository.logout();
        }
      }
    }

    handler.next(err);
  }
}
