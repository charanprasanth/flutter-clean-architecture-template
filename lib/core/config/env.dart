class Env {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String environment = String.fromEnvironment('ENV');

  static bool get isDev => environment == 'dev';
  static bool get isStaging => environment == 'staging';
  static bool get isProd => environment == 'prod';
}
