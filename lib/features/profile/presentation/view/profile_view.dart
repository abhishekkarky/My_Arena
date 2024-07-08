import 'dart:async';
import 'dart:io';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_arena/config/constants/theme_constants.dart';
import 'package:my_arena/config/router/app_routes.dart';
import 'package:my_arena/core/common/provider/is_dark_theme.dart';
import 'package:my_arena/core/common/snackbar/snackbar.dart';
import 'package:my_arena/core/widget/button.dart';
import 'package:my_arena/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:my_arena/features/profile/presentation/widget/profile_menu_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late bool isDark;
  final LocalAuthentication auth = LocalAuthentication();
  bool canAuthenticateWithBiometrics = false;
  final _gap = const SizedBox(
    height: 5,
  );
  late StreamSubscription<ProximityEvent> proximityStream;
  String? fullName;
  String? email;
  String? image;

  @override
  void initState() {
    isDark = ref.read(isDarkThemeProvider);
    super.initState();

    checkBiometricAuthentication();
    _initializeProximity();
  }

  Future<void> checkBiometricAuthentication() async {
    try {
      canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      if (!canAuthenticateWithBiometrics) {
        canAuthenticateWithBiometrics = await auth.isDeviceSupported();
      }
    } catch (e) {}
    if (!mounted) return;
    setState(() {});
  }

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        _img = File(image.path);
        ref.read(authViewModelProvider.notifier).uploadImage(_img!);
        showMySnackBar(
          message: 'Image updated Successfully!!',
          context: context,
        );
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _initializeProximity() {
    proximityStream = proximityEvents!.listen((ProximityEvent event) async {
      if (event.proximity < 1) {
        ref.read(authViewModelProvider.notifier).logout(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authViewModelProvider);
    // final subscriberState = ref.watch(subscriberViewModelProvider);

    // void downloadFile() async {
    //   try {
    //     String? urlString = subscriberState.exportLink;
    //     Uri uri = Uri.parse(urlString!);
    //     http.Response response = await http.get(uri);
    //     Directory? documentsDirectory;
    //     if (Platform.isIOS) {
    //       documentsDirectory = await getApplicationDocumentsDirectory();
    //     } else if (Platform.isMacOS) {
    //       final homeDirectory = Platform.environment['HOME'];
    //       if (homeDirectory != null) {
    //         documentsDirectory = Directory('$homeDirectory/Files');
    //       }
    //     } else if (Platform.isAndroid) {
    //       documentsDirectory = await getExternalStorageDirectory();
    //     } else {
    //       throw 'Unsupported platform';
    //     }

    //     if (documentsDirectory == null) {
    //       throw 'Documents directory is null';
    //     }
    //     String filePath =
    //         '${documentsDirectory.path}/${userState.userDetail!.fullName}-subscribers.csv';

    //     File file = File(filePath);
    //     file.writeAsString(response.body);

    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text('Subscriber exported successfully !!'),
    //       backgroundColor: Colors.green,
    //       duration: Duration(seconds: 3),
    //       behavior: SnackBarBehavior.floating,
    //     ));
    //   } catch (error) {
    //     print('Error downloading file: $error');
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text("Couldn't export !!"),
    //       backgroundColor: Colors.red,
    //       duration: Duration(seconds: 3),
    //       behavior: SnackBarBehavior.floating,
    //     ));
    //   }
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 1,
        actions: [
          Switch(
              value: isDark,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                  ref.read(isDarkThemeProvider.notifier).updateTheme(value);
                });
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => SizedBox(
                      width: double.infinity,
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              'Choose Profile Picture',
                              style: TextStyle(fontSize: 18),
                            ),
                            _gap,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.camera,
                                    color: Colors.red,
                                  ),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _browseImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    color: Colors.green,
                                  ),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          userState.userDetail?.userImageUrl ??
                              'assets/images/userImage.png',
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/userImage.png');
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ThemeConstant.buttonColor,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _gap,
              _gap,
              Text(userState.userDetail?.fullName ?? '',
                  style: Theme.of(context).textTheme.headlineMedium),
              _gap,
              Text(userState.userDetail?.number ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: MAElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.editProfileRoute);
                  },
                  text: 'Edit Profile',
                ),
              ),

              const SizedBox(height: 10),
              const Divider(),

              /// -- MENU
              ProfileMenuWidget(
                title: "Favourite List",
                subTitle: "Your favourite list will appear here",
                icon: FontAwesomeIcons.solidHeart,
                iconColor: Colors.red,
                onPress: () {
                  Navigator.pushNamed(context, AppRoute.favouritesRoute);
                },
              ),
              const Divider(),
              ProfileMenuWidget(
                title: "Edit Password",
                subTitle: "You can change your login credentials",
                icon: FontAwesomeIcons.lock,
                iconColor: isDark ? Colors.white : Colors.black,
                onPress: () {
                  Navigator.pushNamed(context, AppRoute.editPasswordRoute);
                },
              ),
              const Divider(),
              ProfileMenuWidget(
                title: "Logout",
                subTitle: "Signout from the application",
                icon: FontAwesomeIcons.rightFromBracket,
                iconColor: Colors.red,
                endIcon: false,
                onPress: () {
                  ref.read(authViewModelProvider.notifier).logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> updateProfileRoute() async {
  //   bool authenticated = await authenticate();
  //   if (authenticated) {
  //     // ignore: use_build_context_synchronously
  //     Navigator.pushNamed(context, AppRoute.updateProfileRoute);
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     showMySnackBar(
  //       message: 'Authentication failed',
  //       context: context,
  //       color: Colors.red[900],
  //     );
  //   }
  // }

  Future<bool> authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to change profile',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      return authenticated;
    } catch (e) {
      return false;
    }
  }
}
