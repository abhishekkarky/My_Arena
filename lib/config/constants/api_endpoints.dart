class ApiEndpoints {
  ApiEndpoints._();

  static const limitPage = 10;
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://localhost:5500/api/";
  // static const String baseUrl = "http://10.0.2.2:5500/api/";

  // ====================== User Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String updateUser = 'user/editProfile/';
  static const String uploadProfileImage = "user/uploadImage/";
  static const String editUserPassword = 'user/editPassword/';
  static const String requestOTP = 'user/forgot-password';
  static const String resetPassword = 'user/reset-password';
  static const String getUserById = 'user/getUserById/';
  static const String verifyNumber = 'user/number-verify';

  // ====================== Futsal Routes ======================
  static const String getAllFutsals = 'user/futsal/all';

  // ====================== Bookings Routes ======================
  static const String getAllBookings = 'user/bookings/all';

  // ====================== Notification Routes ======================
  static const String getNotifications = 'user/notification/all';
}
