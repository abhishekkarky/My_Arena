import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/config/constants/api_endpoints.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/core/network/http_service.dart';
import 'package:my_arena/core/shared_prefs/user_shared_prefs.dart';
import 'package:my_arena/features/notification/data/dto/get_all_notification.dart';
import 'package:my_arena/features/notification/data/model/notification_api_model.dart';
import 'package:my_arena/features/notification/domain/entity/notification_entity.dart';

final notificationRemoteDataSourceProvider =
    Provider.autoDispose<NotificationRemoteDataSource>(
  (ref) => NotificationRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class NotificationRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  NotificationRemoteDataSource(
      {required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, List<NotificationEntity>>>
      getAllNotifications() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);
      var response = await dio.get(
        ApiEndpoints.getNotifications,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllNotificationsDTO? getAllNotificationsDTO =
            GetAllNotificationsDTO.fromJson(response.data);

        List<NotificationEntity> notificationList = getAllNotificationsDTO.notifications
            .map((notification) => NotificationAPIModel.toEntity(notification))
            .toList();

        return Right(notificationList);
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
