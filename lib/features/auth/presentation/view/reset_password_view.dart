import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_arena/config/router/app_routes.dart';
import 'package:my_arena/core/widget/button.dart';
import 'package:my_arena/core/widget/passwordtextformfield.dart';
import 'package:my_arena/core/widget/textformfield.dart';
import 'package:my_arena/features/auth/presentation/view_model/auth_view_model.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final key = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an OTP';
    } else if (value.length != 4) {
      return 'OTP must be 4 digits';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 8) {
      return 'Password cannot be less than 8 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final number = ModalRoute.of(context)!.settings.arguments;
    // final isLoading = ref.watch(authViewModelProvider).isLoading;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset('assets/images/my_arena_logo.png')),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Check your number for OTP',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Form(
                  key: key,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OTP',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        maTextFormField(
                          isDarkMode: isDarkMode,
                          controller: otpController,
                          hintText: '1234',
                          prefixIcon: FontAwesomeIcons.hashtag,
                          validator: validateOTP,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MAPasswordTextFormField(
                          prefixIcon: FontAwesomeIcons.lock,
                          controller: passwordController,
                          hintText: '*******',
                          validator: validatePassword,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: MAElevatedButton(
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .resetPassword(
                                      context,
                                      number.toString(),
                                      otpController.text,
                                      passwordController.text,
                                    );
                              }
                            },
                            text: 'Change',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoute.loginRoute);
                    },
                    child: const Text(
                      "Back to Login?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
