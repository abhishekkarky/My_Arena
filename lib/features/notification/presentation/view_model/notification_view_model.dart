import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/features/notification/domain/usecase/notification_usecase.dart';
import 'package:my_arena/features/notification/presentation/state/notification_state.dart';

final notificationViewModelProvider =
    StateNotifierProvider<NotificationViewModel, NotificationState>((ref) {
  final notificationUsecase = ref.read(notificationUseCaseProvider);
  return NotificationViewModel(notificationUsecase);
});

class NotificationViewModel extends StateNotifier<NotificationState> {
  final NotificationUseCase notificationUseCase;

  NotificationViewModel(this.notificationUseCase)
      : super(NotificationState.initial()) {
    getNotification();
  }

  Future resetState() async {
    state = NotificationState.initial();
    getNotification();
  }

  Future getNotification() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final notifications = currentState.notifications;
    try {
      final result = await notificationUseCase.getAllNotification();
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) async {
          notifications.clear();
          final newNotifications = [...notifications, ...data];
          state = state.copyWith(
            notifications: newNotifications,
            isLoading: false,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void resetMessage(bool value) {
    state = state.copyWith(isLoading: false);
  }
}
