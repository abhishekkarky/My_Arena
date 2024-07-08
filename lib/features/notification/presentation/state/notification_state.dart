import 'package:my_arena/features/notification/domain/entity/notification_entity.dart';

class NotificationState {
  final List<NotificationEntity> notifications;
  final bool isLoading;
  final bool showMessage;
  final String? error;
  final String? message;

  NotificationState({
    required this.notifications,
    this.error,
    required this.isLoading,
    this.showMessage = false,
    this.message,
  });

  factory NotificationState.initial() {
    return NotificationState(
      notifications: [],
      isLoading: false,
      showMessage: false,
      error: null,
    );
  }

  NotificationState copyWith({
    List<NotificationEntity>? notifications,
    bool? hasReachedMax,
    int? page,
    String? error,
    bool? isLoading,
    bool? showMessage,
    String? searchQuery,
    String? message,
    String? csvName,
    String? subscriberCount,
    String? growthRate,
    List<int>? subscriberGraphData,
    String? exportLink,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      showMessage: showMessage ?? this.showMessage,
      message: message ?? this.message,
    );
  }

  @override
  String toString() =>
      'NotificationState(isLoading: $isLoading, error: $error)';
}
