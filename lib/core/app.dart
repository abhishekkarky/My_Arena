import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/config/router/app_routes.dart';
import 'package:my_arena/config/themes/app_theme.dart';
import 'package:my_arena/core/common/provider/is_dark_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);

    return MaterialApp(
      theme: AppTheme.getApplicationTheme(isDarkTheme),
      debugShowCheckedModeBanner: false,
      title: 'My Arena',
      initialRoute: AppRoute.splashScreenRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
