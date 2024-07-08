import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/config/constants/api_endpoints.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/core/network/http_service.dart';
import 'package:my_arena/core/shared_prefs/user_shared_prefs.dart';
import 'package:my_arena/features/auth/data/dto/get_user_detail.dart';
import 'package:my_arena/features/auth/data/model/auth_api_model.dart';
import 'package:my_arena/features/auth/domain/entity/auth_entity.dart';

final authRemoteDataSourceProvider = Provider.autoDispose<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class AuthRemoteDataSource {
  final Dio dio;
  UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, String>> registerUser(AuthEntity auth) async {
    try {
      AuthAPIModel authAPIModel = AuthAPIModel.fromEntity(auth);
      var response =
          await dio.post(ApiEndpoints.register, data: authAPIModel.toJson());
      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> verifyNumber(
    String number,
    String otp,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.verifyNumber,
        data: {
          "number": number,
          "otp": otp,
        },
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> loginUser(
    String number,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "number": number,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        String token = response.data['token'];
        String message = response.data['message'];
        userSharedPrefs.setUserToken(token);
        userSharedPrefs.setUser(response.data['user']);
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> updateUser(
      String fullName, String email, String address, String number) async {
    try {
      final userData = await userSharedPrefs.getUser();
      String? id = userData?['_id']?.toString() ?? '';
      var response = await dio.put(ApiEndpoints.updateUser + id, data: {
        "fullName": fullName,
        "email": email,
        "address": address,
        "number": number
      });

      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> updateUserPassword(
      String currentPassword, String newPassword) async {
    try {
      final userData = await userSharedPrefs.getUser();
      String? id = userData?['_id']?.toString() ?? '';
      var response = await dio.put(ApiEndpoints.editUserPassword + id, data: {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      });

      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> uploadProfilePicture(File? image) async {
    try {
      if (image == null) {
        return Left(Failure(error: "Image file is null"));
      }

      final userData = await userSharedPrefs.getUser();
      String? id = userData?['_id']?.toString() ?? '';
      FormData formData = FormData.fromMap({
        'userImage': await MultipartFile.fromFile(image.path),
      });

      Response response = await dio.put(
        ApiEndpoints.uploadProfileImage + id,
        data: formData,
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> requestOTP(
    String number,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.requestOTP,
        data: {
          "number": number,
        },
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> resetPassword(
      String number, String otp, String password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.resetPassword,
        data: {"number": number, "otp": otp, "newPassword": password},
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<AuthEntity> getUserById() async {
    try {
      final userData = await userSharedPrefs.getUser();
      String? id = userData?['_id']?.toString() ?? '';

      final response = await dio.get(
        ApiEndpoints.getUserById + id,
      );

      if (response.statusCode == 200) {
        final getUserDetailDTO = GetUserDetailDTO.fromJson(response.data);
        final userDetail = getUserDetailDTO.userDetail;
        return userDetail;
      } else {
        throw Failure(
          error: response.data['message'] ?? 'Unknown error',
          statusCode: response.statusCode.toString(),
        );
      }
    } on DioError catch (e) {
      throw Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      );
    }
  }
}
