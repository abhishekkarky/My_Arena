import 'package:my_arena/features/auth/presentation/view/login_view.dart';
import 'package:my_arena/features/auth/presentation/view/register_view.dart';
import 'package:my_arena/features/auth/presentation/view/request_otp_view.dart';
import 'package:my_arena/features/auth/presentation/view/reset_password_view.dart';
import 'package:my_arena/features/bookings/presentation/view/bookings_view.dart';
import 'package:my_arena/features/discover/presentation/view/discover_view.dart';
import 'package:my_arena/features/discover/presentation/view/individual_futsal_view.dart';
import 'package:my_arena/features/discover/presentation/view/map_view.dart';
import 'package:my_arena/features/profile/presentation/view/favourites_view.dart';
import 'package:my_arena/features/home/presentation/view/home_view.dart';
import 'package:my_arena/features/profile/presentation/view/edit_password_view.dart';
import 'package:my_arena/features/profile/presentation/view/edit_profile_view.dart';
import 'package:my_arena/features/splash/presentation/view/splash_screen_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashScreenRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String requestOTPRoute = '/request-otp';
  static const String resetPasswordRoute = '/reset-password';
  static const String editProfileRoute = '/edit-profile';
  static const String editPasswordRoute = '/edit-password';
  static const String favouritesRoute = '/favourites';
  static const String bookingsRoute = '/bookings';

  static const String discoverRoute = '/discover';
  static const String individualFutsalRoute = '/individual-futsal';
  static const String mapViewRoute = '/map-view';

  static getApplicationRoute() {
    return {
      splashScreenRoute: (context) => const SplashscreenView(),
      homeRoute: (context) => const PrimaryView(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      requestOTPRoute: (context) => const RequestOTPView(),
      resetPasswordRoute: (context) => const ResetPasswordView(),
      editProfileRoute: (context) => const EditProfileView(),
      editPasswordRoute: (context) => const EditPasswordView(),
      discoverRoute: (context) => const DiscoverView(),
      favouritesRoute: (context) => const FavouritesView(),
      individualFutsalRoute: (context) => const IndividualFutsalView(),
      mapViewRoute: (context) => const FutsalMapView(),
      bookingsRoute: (context) => const BookingsView(),
    };
  }
}
