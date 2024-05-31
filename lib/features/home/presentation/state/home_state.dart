import 'package:flutter/material.dart';
import 'package:my_arena/features/bookings/presentation/view/bookings_view.dart';
import 'package:my_arena/features/discover/presentation/view/discover_view.dart';
import 'package:my_arena/features/notification/presentation/view/notification_view.dart';
import 'package:my_arena/features/profile/presentation/view/profile_view.dart';

class HomeState {
  final int index;
  final List<Widget> lstWidget;

  HomeState({required this.index, required this.lstWidget});

  HomeState.initialState()
      : index = 0,
        lstWidget = [
          const DiscoverView(),
          const BookingsView(),
          const NotificationView(),
          const ProfileView(),
        ];

  HomeState copyWith({
    int? index,
  }) {
    return HomeState(
      index: index ?? this.index,
      lstWidget: lstWidget,
    );
  }
}
