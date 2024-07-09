import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_arena/config/router/app_routes.dart';
import 'package:my_arena/core/widget/button.dart';
import 'package:my_arena/core/widget/passwordtextformfield.dart';
import 'package:my_arena/core/widget/textformfield.dart';
import 'package:my_arena/features/auth/domain/entity/auth_entity.dart';
import 'package:my_arena/features/auth/presentation/view_model/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final key = GlobalKey<FormState>();
  final nameController = TextEditingController(text: "");
  final numberController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    if (value.length < 10 || value.length > 10) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Password cannot be less than 8 characters';
    } else if (value.length > 15) {
      return 'Password cannot be more than 15 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authState.showMessage) {
        ref.read(authViewModelProvider.notifier).resetMessage(false);
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset('assets/images/my_arena_logo.png')),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'MY ARENA',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Register here',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Form(
                  key: key,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        maTextFormField(
                          isDarkMode: isDarkMode,
                          controller: nameController,
                          hintText: 'John Doe',
                          prefixIcon: FontAwesomeIcons.user,
                          validator: validateName,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                          validator: validateNumber,
                        ),
                        const SizedBox(
                          height: 10,
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
                          height: 25,
                        ),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: MAElevatedButton(
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                AuthEntity auth = AuthEntity(
                                  fullName: nameController.text,
                                  number: numberController.text,
                                  password: passwordController.text,
                                );
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .registerUser(auth, context);
                              }
                            },
                            text: 'Register',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoute.loginRoute);
                    },
                    child: const Text(
                      "Already have an account?",
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
