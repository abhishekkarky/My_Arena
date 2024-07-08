import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/auth/data/repository/auth_remote_repository.dart';
import 'package:my_arena/features/auth/domain/entity/auth_entity.dart';

final authRepositoryProvider = Provider.autoDispose<IAuthRepository>(
    (ref) => ref.read(authRemoteRepositoryProvider));

abstract class IAuthRepository {
  Future<Either<Failure, String>> registerUser(AuthEntity auth);
  Future<Either<Failure, String>> verifyNumber(String number, String otp);
  Future<Either<Failure, String>> loginUser(String number, String password);
  Future<Either<Failure, String>> updateUser(
      String fullName, String email, String address, String number);
  Future<Either<Failure, String>> updateUserPassword(
      String currentPassword, String newPassword);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, String>> requestOTP(String number);
  Future<Either<Failure, String>> resetPassword(
      String number, String otp, String password);
  Future<AuthEntity> getUserById();
}
