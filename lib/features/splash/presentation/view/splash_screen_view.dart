import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/config/router/app_routes.dart';
import 'package:my_arena/core/shared_prefs/user_shared_prefs.dart';

class SplashscreenView extends ConsumerStatefulWidget {
  const SplashscreenView({super.key});

  @override
  ConsumerState<SplashscreenView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashscreenView> {
  final userSharedPrefs = UserSharedPrefs().getUserToken();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      userSharedPrefs.then((value) {
        value.fold((l) => null, (token) {
          if (token != null) {
            Navigator.popAndPushNamed(context, AppRoute.homeRoute);
          } else {
            Navigator.popAndPushNamed(context, AppRoute.loginRoute);
          }
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/my_arena_logo.png')),
                const Text(
                  'My Arena',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                CircularProgressIndicator(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                const SizedBox(height: 20),
                const Text('version : 1.0.0')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
