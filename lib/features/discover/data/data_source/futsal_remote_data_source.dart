import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/config/constants/api_endpoints.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/core/network/http_service.dart';
import 'package:my_arena/core/shared_prefs/user_shared_prefs.dart';
import 'package:my_arena/features/discover/data/dto/get_all_futsal.dart';
import 'package:my_arena/features/discover/data/model/futsal_model.dart';
import 'package:my_arena/features/discover/domain/entity/futsal_entity.dart';

final futsalRemoteDataSourceProvider =
    Provider.autoDispose<FutsalRemoteDataSource>(
  (ref) => FutsalRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class FutsalRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  FutsalRemoteDataSource(
      {required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, List<FutsalEntity>>> getAllFutsals(
      int page) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);
      var response = await dio.get(
        ApiEndpoints.getAllFutsals,
        queryParameters: {
          'page': page,
          'limit': ApiEndpoints.limitPage,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllFutsalDTO? getAllFutsalDTO =
            GetAllFutsalDTO.fromJson(response.data);

        List<FutsalEntity> futsalList = getAllFutsalDTO.futsals
            .map((futsal) => FutsalAPIModel.toEntity(futsal))
            .toList();

        return Right(futsalList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage?.toString() ?? 'Unknown error',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message']?.toString() ?? 'An error occurred';
      return Left(Failure(error: errorMessage));
    }
  }
}
