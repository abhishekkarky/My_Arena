import 'package:flutter/material.dart';
import 'package:my_arena/config/constants/theme_constants.dart';

TextFormField maTextFormField({
  required TextEditingController controller,
  required String hintText,
  String? validatorText,
  String? initialValue,
  TextInputType? keyboardType,
  IconData? prefixIcon,
  Color prefixIconColor = ThemeConstant.buttonColor,
  Color? prefixIconBackgroundColor,
  Color? backgroundColor,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    initialValue: initialValue,
    keyboardType: keyboardType,
    validator: validator ??
        (value) {
          if (value!.isEmpty) {
            return validatorText;
          }
          return null;
        },
    decoration: InputDecoration(
      filled: true,
      fillColor: backgroundColor ?? const Color(0xFFE5E5E5),
      hintText: hintText,
      prefixIcon: prefixIcon != null
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: prefixIconBackgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                prefixIcon,
                color: prefixIconColor,
                size: 18,
              ),
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
