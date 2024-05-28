import 'package:flutter/material.dart';
import 'package:my_arena/config/constants/theme_constants.dart';

class MAElevatedButton extends StatefulWidget {
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
  State<MAElevatedButton> createState() => _MAElevatedButtonState();
}

class _MAElevatedButtonState extends State<MAElevatedButton> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode
            ? Colors.white
            : widget.backgroundColor ?? ThemeConstant.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontFamily: 'Roboto Slab Regular',
          fontSize: 18,
          color: isDarkMode
              ? Colors.black
              : widget.backgroundColor ?? ThemeConstant.darkTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
