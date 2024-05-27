import 'package:flutter/material.dart';
import 'package:my_arena/config/constants/theme_constants.dart';

class MAElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const MAElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ThemeConstant.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Roboto Slab Regular',
          fontSize: 18,
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
