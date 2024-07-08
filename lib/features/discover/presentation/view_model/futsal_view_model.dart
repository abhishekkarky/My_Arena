import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/features/discover/domain/usecase/futsal_use_case.dart';
import 'package:my_arena/features/discover/presentation/state/futsal_state.dart';

final futsalViewModelProvider =
    StateNotifierProvider<FutsalViewModel, FutsalState>((ref) {
  final futsalUseCase = ref.read(futsalUseCaseProvider);
  return FutsalViewModel(futsalUseCase);
});

class FutsalViewModel extends StateNotifier<FutsalState> {
  final FutsalUseCase futsalUseCase;

  FutsalViewModel(this.futsalUseCase) : super(FutsalState.initial()) {
    getFutsals();
  }

  Future resetState() async {
    state = FutsalState.initial();
    getFutsals();
  }

  Future getFutsals() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final futsals = currentState.futsals;
    final hasReachedMax = currentState.hasReachedMax;

    try {
      if (!hasReachedMax) {
        final result = await futsalUseCase.getAllFutsals(page);
        result.fold(
          (failure) =>
              state = state.copyWith(hasReachedMax: true, isLoading: false),
          (data) async {
            futsals.clear();
            final newFutsals = [...futsals, ...data];
            state = state.copyWith(
              futsals: newFutsals,
              page: page,
              isLoading: false,
            );
          },
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void applyFilters(String searchQuery, RangeValues priceRange) {
    var filteredFutsals = state.futsals.where((futsal) {
      return futsal.name!.toLowerCase().contains(searchQuery.toLowerCase()) &&
             futsal.price! >= priceRange.start &&
             futsal.price! <= priceRange.end;
    }).toList();

    state = state.copyWith(futsals: filteredFutsals);
  }

  void resetMessage(bool value) {
    state = state.copyWith(isLoading: false);
  }
}
