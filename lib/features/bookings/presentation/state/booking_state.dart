import 'package:my_arena/features/bookings/domain/entity/booking_entity.dart';

class BookingState {
  final List<BookingEntity> bookingsData;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;
  final bool showMessage;
  final String? error;
  final String? message;

  BookingState({
    required this.bookingsData,
    required this.hasReachedMax,
    required this.page,
    this.error,
    required this.isLoading,
    this.showMessage = false,
    this.message,
  });

  factory BookingState.initial() {
    return BookingState(
      bookingsData: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
      showMessage: false,
      error: null,
    );
  }

  BookingState copyWith({
    List<BookingEntity>? bookingsData,
    bool? hasReachedMax,
    int? page,
    String? error,
    bool? isLoading,
    bool? showMessage,
    String? message,
  }) {
    return BookingState(
      bookingsData: bookingsData ?? this.bookingsData,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      showMessage: showMessage ?? this.showMessage,
      message: message ?? this.message,
    );
  }

  @override
  String toString() => 'BookingState(isLoading: $isLoading, error: $error)';
}
