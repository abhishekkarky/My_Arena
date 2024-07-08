import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/notification/data/data_source/notification_data_source.dart';
import 'package:my_arena/features/notification/domain/entity/notification_entity.dart';
import 'package:my_arena/features/notification/domain/repository/notification_repository.dart';

final notificationRemoteRepositoryProvider =
    Provider.autoDispose<NotificationRemoteRepoImpl>(
  (ref) => NotificationRemoteRepoImpl(
    notificationRemoteDataSource: ref.read(notificationRemoteDataSourceProvider),
  ),
);

class NotificationRemoteRepoImpl implements INotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRemoteRepoImpl(
      {required this.notificationRemoteDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification() {
    return notificationRemoteDataSource.getAllNotifications();
  }
}
