import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/auth_session.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../network/api_client.dart';
import '../services/logger_service.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/referesh_token_interceptor.dart';
import '../network/interceptors/error_interceptor.dart';
import '../network/interceptors/logging_interceptor.dart';
import '../config/env.dart';
import '../services/secure_storage_service.dart';
import '../../features/auth/data/auth_repository.dart';
import '../theme/theme_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<LoggerService>(() => LoggerService());

  // Dio
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(),
      RefreshTokenInterceptor(),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);

    return dio;
  });

  // Network
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl()));

  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl(), sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
  sl.registerLazySingleton<AuthSession>(() => AuthSession(sl()));

  sl.registerLazySingleton<ThemeService>(() => ThemeService());
}
