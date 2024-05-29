import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_arena/core/widget/button.dart';
import 'package:my_arena/core/widget/textformfield.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final numberController = TextEditingController();
  final _gapBetweenFields = const SizedBox(
    height: 15,
  );
  final _normalGap = const SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // final authState = ref.watch(authViewModelProvider);
    // nameController.text = authState.userDetail?.fullName ?? '';
    // emailController.text = authState.userDetail?.email ?? '';
    // addressController.text = authState.userDetail?.address ?? '';
    // numberController.text = authState.userDetail?.number ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Fullname",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                _normalGap,
                maTextFormField(
                  isDarkMode: isDarkMode,
                  controller: nameController,
                  hintText: "Fullname",
                  validatorText: "Fullname is required!!",
                  prefixIcon: FontAwesomeIcons.solidUser,
                ),
                _gapBetweenFields,
                const Text(
                  "Email address",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                _normalGap,
                maTextFormField(
                  isDarkMode: isDarkMode,
                  controller: emailController,
                  hintText: "Email address",
                  validatorText: "Email is required!!",
                  prefixIcon: FontAwesomeIcons.at,
                ),
                _gapBetweenFields,
                const Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                _normalGap,
                maTextFormField(
                  isDarkMode: isDarkMode,
                  controller: addressController,
                  hintText: "Address",
                  validatorText: "Address is required!!",
                  prefixIcon: FontAwesomeIcons.locationDot,
                ),
                _gapBetweenFields,
                const Text(
                  "Number",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                _normalGap,
                maTextFormField(
                  isDarkMode: isDarkMode,
                  controller: numberController,
                  hintText: "Number",
                  validatorText: "Number is required!!",
                  keyboardType: TextInputType.phone,
                  prefixIcon: FontAwesomeIcons.phone,
                ),
                _gapBetweenFields,
                _gapBetweenFields,
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: MAElevatedButton(
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          // await ref
                          //     .read(authViewModelProvider.notifier)
                          //     .updateUser(
                          //         nameController.text,
                          //         emailController.text,
                          //         addressController.text,
                          //         numberController.text,
                          //         context);
                        }
                      },
                      text: 'Update',
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
