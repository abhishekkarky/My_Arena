import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/core/shared_prefs/user_shared_prefs.dart';
import 'package:my_arena/features/auth/domain/entity/auth_entity.dart';
import 'package:my_arena/features/auth/domain/repository/auth_repository.dart';

final authUseCaseProvider = Provider.autoDispose<AuthUseCase>((ref) =>
    AuthUseCase(
        repository: ref.read(authRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class AuthUseCase {
  final IAuthRepository repository;
  final UserSharedPrefs userSharedPrefs;

  AuthUseCase({required this.repository, required this.userSharedPrefs});

  Future<Either<Failure, String>> registerUser(AuthEntity auth) async {
    return await repository.registerUser(auth);
  }

  Future<Either<Failure, String>> verifyNumber(
    String number,
    String otp,
  ) async {
    return await repository.verifyNumber(number, otp);
  }

  Future<Either<Failure, String>> loginUser(
    String number,
    String password,
  ) async {
    return await repository.loginUser(number, password);
  }

  Future<Either<Failure, String>> updateUser(
      String fullName, String email, String address, String number) async {
    return await repository.updateUser(fullName, email, address, number);
  }

  Future<Either<Failure, String>> updateUserPassword(
      String currentPassword, String newPassword) async {
    return await repository.updateUserPassword(currentPassword, newPassword);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File? file) async {
    if (file == null) {
      return Left(Failure(error: "File is null"));
    }

    return await repository.uploadProfilePicture(file);
  }

  Future<Either<Failure, String>> requestOTP(
    String number,
  ) async {
    return await repository.requestOTP(number);
  }

  Future<Either<Failure, String>> resetPassword(
      String number, String otp, String password) async {
    return await repository.resetPassword(number, otp, password);
  }

  Future<AuthEntity> getUserById() async {
    return await repository.getUserById();
  }
}
