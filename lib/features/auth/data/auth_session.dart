import '../../../core/services/secure_storage_service.dart';

class AuthSession {
  final SecureStorageService _storage;

  AuthSession(this._storage);

  Future<bool> isLoggedIn() async {
    final token = await _storage.getAccessToken();
    return token != null;
  }
}
