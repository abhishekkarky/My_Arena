import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_arena/config/constants/theme_constants.dart';

class MAPasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? validatorText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Color prefixIconColor;
  final String? Function(String?)? validator;

  const MAPasswordTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validatorText,
    this.initialValue,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
    this.prefixIconColor = ThemeConstant.buttonColor,
  }); // Added super call

  @override
  _MAPasswordTextFormFieldState createState() =>
      _MAPasswordTextFormFieldState();
}

class _MAPasswordTextFormFieldState extends State<MAPasswordTextFormField> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      validator: widget.validator ??
          (value) {
            if (value!.isEmpty) {
              return widget.validatorText;
            }
            return null;
          },
      obscureText: obscurePassword,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.grey[600] : Colors.grey,
        ),
        filled: true,
        fillColor: const Color(0xFFE5E5E5),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: widget.prefixIconColor,
                size: 18,
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
        suffixIcon: IconButton(
          icon: FaIcon(
            obscurePassword
                ? FontAwesomeIcons.solidEyeSlash
                : FontAwesomeIcons.solidEye,
            color: widget.prefixIconColor,
            size: 18,
          ),
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
