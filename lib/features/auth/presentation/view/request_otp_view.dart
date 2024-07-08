import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_arena/config/router/app_routes.dart';
import 'package:my_arena/core/widget/button.dart';
import 'package:my_arena/core/widget/textformfield.dart';
import 'package:my_arena/features/auth/presentation/view_model/auth_view_model.dart';

class RequestOTPView extends ConsumerStatefulWidget {
  const RequestOTPView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestOTPViewState();
}

class _RequestOTPViewState extends ConsumerState<RequestOTPView> {
  final key = GlobalKey<FormState>();
  final numberController = TextEditingController();
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    if (value.length < 10 || value.length > 10) {
      return 'Please enter a valid number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                  'Forgot password ?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Enter your email address',
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
                          'Number',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        maTextFormField(
                          isDarkMode: isDarkMode,
                          controller: numberController,
                          hintText: '9800000000',
                          prefixIcon: FontAwesomeIcons.phone,
                          validator: validatePhone,
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
                                Navigator.pushNamed(
                                    context, AppRoute.resetPasswordRoute);
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .requestOTP(
                                      context,
                                      numberController.text,
                                    );
                              }
                            },
                            text: 'Request OTP',
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
