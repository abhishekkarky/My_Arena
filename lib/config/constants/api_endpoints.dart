class ApiEndpoints {
  ApiEndpoints._();

  static const limitPage = 8;
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://localhost:5500/api/";
  // static const String baseUrl = "http://10.0.2.2:5500/api/";

  // ====================== User Routes ======================
  static const String login = "user/login";
}
