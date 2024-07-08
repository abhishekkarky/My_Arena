import 'package:my_arena/features/discover/domain/entity/futsal_entity.dart';

class FutsalState {
  final List<FutsalEntity> futsals;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;
  final bool showMessage;
  final String? error;
  final String? message;

  FutsalState({
    required this.futsals,
    required this.hasReachedMax,
    required this.page,
    this.error,
    required this.isLoading,
    this.showMessage = false,
    this.message,
  });

  factory FutsalState.initial() {
    return FutsalState(
      futsals: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
      showMessage: false,
      error: null,
    );
  }

  FutsalState copyWith({
    List<FutsalEntity>? futsals,
    bool? hasReachedMax,
    int? page,
    String? error,
    bool? isLoading,
    bool? showMessage,
    String? message,
  }) {
    return FutsalState(
      futsals: futsals ?? this.futsals,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      showMessage: showMessage ?? this.showMessage,
      message: message ?? this.message,
    );
  }

  @override
  String toString() => 'FutsalState(isLoading: $isLoading, error: $error)';
}
