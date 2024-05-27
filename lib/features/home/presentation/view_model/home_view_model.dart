import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/config/router/app_routes.dart';

import '../state/home_state.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState.initialState());

  void changeIndex(int index) {
    state = state.copyWith(index: index);
  }

  void signOut(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
  }
}
