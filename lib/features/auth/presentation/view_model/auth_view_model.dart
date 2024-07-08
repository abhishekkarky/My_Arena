import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/config/router/app_routes.dart';
import 'package:my_arena/core/common/snackbar/snackbar.dart';
import 'package:my_arena/core/shared_prefs/user_shared_prefs.dart';
import 'package:my_arena/features/auth/domain/entity/auth_entity.dart';
import 'package:my_arena/features/auth/domain/use_case/auth_usecase.dart';
import 'package:my_arena/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider.autoDispose<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    authUseCase: ref.read(authUseCaseProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;
  UserSharedPrefs userSharedPrefs;

  AuthViewModel({
    required this.userSharedPrefs,
    required this.authUseCase,
  }) : super(AuthState.initialState()) {
    getUserById();
  }

  Future<void> registerUser(AuthEntity auth, BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);
      final result = await authUseCase.registerUser(auth);
      state = state.copyWith(isLoading: false);
      result.fold(
        (failure) {
          state = state.copyWith(
            error: failure.error,
            isLoading: false,
            showMessage: true,
          );
          showMySnackBar(
            message: state.error!,
            context: context,
            color: Colors.red[900],
          );
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            message: success,
            showMessage: true,
            error: null,
          );
          showMySnackBar(
            message: state.message!,
            context: context,
          );
          // Navigator.popAndPushNamed(context, AppRoute., arguments: auth);
        },
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error registering',
        isLoading: false,
        showMessage: true,
      );
    }
  }

  Future<void> verifyEmail(
      BuildContext context, String number, String otp) async {
    try {
      state = state.copyWith(isLoading: true);
      final result = await authUseCase.verifyNumber(number, otp);
      state = state.copyWith(isLoading: false);

      result.fold(
        (failure) {
          state = state.copyWith(
            error: failure.error,
            isLoading: false,
            showMessage: true,
          );
          showMySnackBar(
            message: state.error!,
            context: context,
            color: Colors.red[900],
          );
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            message: success,
            showMessage: true,
            error: null,
          );
          showMySnackBar(
            message: success,
            context: context,
          );
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.loginRoute, (route) => false);
        },
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error logging in user',
        isLoading: false,
        showMessage: true,
      );
    }
  }

  Future<void> loginUser(
      BuildContext context, String number, String password) async {
    try {
      state = state.copyWith(isLoading: true);
      final result = await authUseCase.loginUser(number, password);
      state = state.copyWith(isLoading: false);

      result.fold(
        (failure) {
          state = state.copyWith(
            error: failure.error,
            isLoading: false,
            showMessage: true,
          );
          showMySnackBar(
            message: state.error!,
            context: context,
            color: Colors.red[900],
          );
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            message: success,
            showMessage: true,
            error: null,
          );
          showMySnackBar(
            message: success,
            context: context,
          );
          getUserById();
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.homeRoute, (route) => false);
        },
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error logging in user',
        isLoading: false,
        showMessage: true,
      );
    }
  }

  Future<void> updateUser(String fullName, String email, String address,
      String number, BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);
      final result =
          await authUseCase.updateUser(fullName, email, address, number);
      state = state.copyWith(isLoading: false);
      result.fold(
        (failure) {
          state = state.copyWith(
            error: failure.error,
            isLoading: false,
            showMessage: true,
          );
          showMySnackBar(
            message: state.error!,
            context: context,
            color: Colors.red[900],
          );
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            message: success,
            showMessage: true,
            error: null,
          );
          getUserById();
          showMySnackBar(
            message: state.message!,
            context: context,
          );
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.homeRoute, (route) => false);
        },
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error updating',
        isLoading: false,
        showMessage: true,
      );
    }
  }

  Future<void> updateUserPassword(
      String currentPassword, String newPassword, BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);
      final result =
          await authUseCase.updateUserPassword(currentPassword, newPassword);
      state = state.copyWith(isLoading: false);
      result.fold(
        (failure) {
          state = state.copyWith(
            error: failure.error,
            isLoading: false,
            showMessage: true,
          );
          showMySnackBar(
            message: state.error!,
            context: context,
            color: Colors.red[900],
          );
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            message: success,
            showMessage: true,
            error: null,
          );
          showMySnackBar(
            message: state.message!,
            context: context,
          );
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.homeRoute, (route) => false);
        },
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error updating password',
        isLoading: false,
        showMessage: true,
      );
    }
  }

  Future<void> uploadImage(File? file) async {
    if (file == null) {
      return;
    }

    state = state.copyWith(isLoading: true);
    var data = await authUseCase.uploadProfilePicture(file);

    data.fold(
      (failure) {
        state = state.copyWith(
          error: failure.error,
          isLoading: false,
          showMessage: true,
        );
        showMySnackBar(
          message: 'Error updating image',
          color: Colors.red[900],
        );
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          message: success,
          showMessage: true,
          error: null,
          imageName: success,
        );
        getUserById();
        showMySnackBar(
          message: 'Image updated successfully!',
        );
      },
    );
  }

  Future<void> requestOTP(BuildContext context, String number) async {
    try {
      state = state.copyWith(isLoading: true);
      final result = await authUseCase.requestOTP(number);
      state = state.copyWith(isLoading: false);

      result.fold(
        (failure) {
          state = state.copyWith(
            error: failure.error,
            isLoading: false,
            showMessage: true,
          );
          showMySnackBar(
            message: state.error!,
            context: context,
            color: Colors.red[900],
          );
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            message: success,
            showMessage: true,
            error: null,
          );
          Navigator.popAndPushNamed(context, AppRoute.resetPasswordRoute,
              arguments: number);
        },
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error requesting otp',
        isLoading: false,
        showMessage: true,
      );
    }
  }

  Future<void> resetPassword(
      BuildContext context, String number, String otp, String password) async {
    try {
      state = state.copyWith(isLoading: true);
      final result = await authUseCase.resetPassword(number, otp, password);
      state = state.copyWith(isLoading: false);

      result.fold(
        (failure) {
          state = state.copyWith(
            error: failure.error,
            isLoading: false,
            showMessage: true,
          );
          showMySnackBar(
            message: state.error!,
            context: context,
            color: Colors.red[900],
          );
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            message: success,
            showMessage: true,
            error: null,
          );
          showMySnackBar(
            message: success,
            context: context,
          );
          Navigator.popAndPushNamed(context, AppRoute.loginRoute);
        },
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error logging in user',
        isLoading: false,
        showMessage: true,
      );
    }
  }

  Future<void> getUserById() async {
    state = state.copyWith(isLoading: true);

    final result = await authUseCase.getUserById();

    state = state.copyWith(
      userDetail: result,
      isLoading: false,
    );
  }

  void logout(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    showMySnackBar(
      message: 'See you soon. Bye!!',
      context: context,
    );

    await userSharedPrefs.deleteUserToken();
    Future.delayed(const Duration(milliseconds: 1000), () {
      state = state.copyWith(isLoading: true);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.loginRoute,
        (route) => false,
      );
    });
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: false, error: null, isLoading: false);
  }
}
