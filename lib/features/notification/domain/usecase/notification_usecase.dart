import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/notification/domain/entity/notification_entity.dart';
import 'package:my_arena/features/notification/domain/repository/notification_repository.dart';

final notificationUseCaseProvider = Provider.autoDispose<NotificationUseCase>(
    (ref) => NotificationUseCase(
        repository: ref.read(notificationRepositoryProvider)));

class NotificationUseCase {
  final INotificationRepository repository;

  NotificationUseCase({required this.repository});

  Future<Either<Failure, List<NotificationEntity>>> getAllNotification() async {
    return await repository.getAllNotification();
  }
}
