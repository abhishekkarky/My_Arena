import 'package:my_arena/features/auth/presentation/view/login_view.dart';
import 'package:my_arena/features/auth/presentation/view/register_view.dart';
import 'package:my_arena/features/auth/presentation/view/request_otp_view.dart';
import 'package:my_arena/features/auth/presentation/view/reset_password_view.dart';
import 'package:my_arena/features/discover/presentation/view/discover_view.dart';
import 'package:my_arena/features/home/presentation/view/home_view.dart';
import 'package:my_arena/features/splash/presentation/view/splash_screen_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashScreenRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String requestOTPRoute = '/request-otp';
  static const String resetPasswordRoute = '/reset-password';

  static const String discoverRoute = '/discover';

  static getApplicationRoute() {
    return {
      splashScreenRoute: (context) => const SplashscreenView(),
      homeRoute: (context) => const PrimaryView(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      requestOTPRoute: (context) => const RequestOTPView(),
      resetPasswordRoute: (context) => const ResetPasswordView(),

      discoverRoute: (context) => const DiscoverView(),
    };
  }
}
