import 'package:flutter/material.dart';
import 'package:my_arena/config/constants/theme_constants.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme(bool isDark) {
    return ThemeData(
      // change the theme according to the user choice
      colorScheme: isDark
          ? const ColorScheme.dark(
              primary: ThemeConstant.buttonColor, secondary: Colors.white)
          : const ColorScheme.light(
              primary: ThemeConstant.buttonColor,
              secondary: Colors.black,
            ),
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: 'Roboto Slab Regular',
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: isDark ? Colors.white : Colors.black),
        bodyMedium: TextStyle(color: isDark ? Colors.white : Colors.black),
        bodySmall: TextStyle(color: isDark ? Colors.white : Colors.black),
      ),

      dividerTheme: DividerThemeData(
        color: isDark ? Colors.white12 : Colors.black12,
      ),

      // Change app bar color
      appBarTheme: AppBarTheme(
        elevation: 10,
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.white,
        titleTextStyle: TextStyle(
          color: isDark
              ? ThemeConstant.darkTextColor
              : ThemeConstant.lightTextColor,
          fontSize: 21,
          fontFamily: 'Roboto Slab Regular',
          fontWeight: FontWeight.w500,
        ),
      ),

      // Change elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: isDark ? Colors.black : Colors.white,
          backgroundColor: isDark ? Colors.white : Colors.black,
          textStyle: const TextStyle(
            fontSize: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // Change text field theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(18),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        labelStyle: const TextStyle(
          fontSize: 18,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: ThemeConstant.buttonColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      // Circular progress bar theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeConstant.buttonColor,
      ),
    );
  }
}
