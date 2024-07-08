import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/notification/data/repository/notification_remote_repository.dart';
import 'package:my_arena/features/notification/domain/entity/notification_entity.dart';

final notificationRepositoryProvider =
    Provider.autoDispose<INotificationRepository>(
  (ref) {
    return ref.read(notificationRemoteRepositoryProvider);
  },
);

abstract class INotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification();
}
