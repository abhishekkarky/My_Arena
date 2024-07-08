import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:my_arena/features/auth/domain/entity/auth_entity.dart';
import 'package:my_arena/features/auth/domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider.autoDispose<IAuthRepository>(
  (ref) => AuthRemoteRepoImpl(
    authRemoteDataSource: ref.read(authRemoteDataSourceProvider),
  ),
);

class AuthRemoteRepoImpl implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepoImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, String>> registerUser(AuthEntity auth) async {
    final result = await authRemoteDataSource.registerUser(auth);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> verifyNumber(
      String number, String otp) async {
    final result = await authRemoteDataSource.verifyNumber(number, otp);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String number, String password) async {
    final result = await authRemoteDataSource.loginUser(number, password);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> updateUser(
      String fullName, String email, String address, String number) async {
    final result =
        await authRemoteDataSource.updateUser(fullName, email, address, number);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> updateUserPassword(
      String currentPassword, String newPassword) async {
    final result = await authRemoteDataSource.updateUserPassword(
        currentPassword, newPassword);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    final result = await authRemoteDataSource.uploadProfilePicture(file);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> requestOTP(String number) async {
    final result = await authRemoteDataSource.requestOTP(number);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      String number, String otp, String password) async {
    final result =
        await authRemoteDataSource.resetPassword(number, otp, password);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<AuthEntity> getUserById() {
    return authRemoteDataSource.getUserById();
  }
}
