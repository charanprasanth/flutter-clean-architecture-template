import '../../../core/network/api_client.dart';
import '../../../core/services/secure_storage_service.dart';
import '../domain/auth_tokens.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final SecureStorageService _storage;

  AuthRepository(this._apiClient, this._storage);

  Future<AuthTokens> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    final tokens = AuthTokens(
      accessToken: response['accessToken'],
      refreshToken: response['refreshToken'],
    );

    await _storage.saveAccessToken(tokens.accessToken);
    await _storage.saveRefreshToken(tokens.refreshToken);

    return tokens;
  }

  Future<AuthTokens> refreshToken() async {
    final refreshToken = await _storage.getRefreshToken();

    final response = await _apiClient.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {
        'refreshToken': refreshToken,
      },
    );

    final tokens = AuthTokens(
      accessToken: response['accessToken'],
      refreshToken: response['refreshToken'],
    );

    await _storage.saveAccessToken(tokens.accessToken);
    await _storage.saveRefreshToken(tokens.refreshToken);

    return tokens;
  }

  Future<void> logout() async {
    await _storage.clearTokens();
  }
}
