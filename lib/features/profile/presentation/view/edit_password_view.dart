import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_arena/core/widget/button.dart';
import 'package:my_arena/core/widget/passwordtextformfield.dart';

class EditPasswordView extends ConsumerStatefulWidget {
  const EditPasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditPasswordViewState();
}

class _EditPasswordViewState extends ConsumerState<EditPasswordView> {
  final key = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

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

  String? validateConfirmedPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  final normalgap = const SizedBox(
    height: 10,
  );
  final gapBetweenFields = const SizedBox(
    height: 15,
  );
  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authViewModelProvider);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (authState.showMessage) {
    //     showMySnackBar(
    //       message: authState.message!,
    //       context: context,
    //     );
    //     ref.read(authViewModelProvider.notifier).resetMessage(false);
    //   }
    // });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Password',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current password',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              normalgap,
              MAPasswordTextFormField(
                controller: currentPasswordController,
                hintText: 'Current password...',
                prefixIcon: FontAwesomeIcons.lock,
                validator: validatePassword,
              ),
              gapBetweenFields,
              const Text(
                'New password',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              normalgap,
              MAPasswordTextFormField(
                controller: newPasswordController,
                hintText: 'New password...',
                prefixIcon: FontAwesomeIcons.lock,
                validator: validatePassword,
              ),
              gapBetweenFields,
              const Text(
                'Confirm password',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              normalgap,
              MAPasswordTextFormField(
                controller: confirmNewPasswordController,
                hintText: 'Confirm password...',
                prefixIcon: FontAwesomeIcons.lock,
                validator: validateConfirmedPassword,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: MAElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      // if (newPasswordController.text ==
                      //     confirmNewPasswordController.text) {
                      //   await ref
                      //       .read(authViewModelProvider.notifier)
                      //       .updateUserPassword(
                      //         currentPasswordController.text,
                      //         newPasswordController.text,
                      //         context,
                      //       );
                      // } else {
                      //   showMySnackBar(
                      //     message:
                      //         'New password and confirm password do not match',
                      //     context: context,
                      //     color: Colors.red[900],
                      //   );
                      // }
                    }
                  },
                  text: 'Change',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
