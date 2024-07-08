import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/features/bookings/domain/usecase/booking_usecase.dart';
import 'package:my_arena/features/bookings/presentation/state/booking_state.dart';

final bookingViewModelProvider =
    StateNotifierProvider<BookingViewModel, BookingState>((ref) {
  final bookingUsecase = ref.read(bookingUseCaseProvider);
  return BookingViewModel(bookingUsecase);
});

class BookingViewModel extends StateNotifier<BookingState> {
  final BookingUseCase bookingUseCase;

  BookingViewModel(this.bookingUseCase) : super(BookingState.initial()) {
    getBookings();
  }

  Future resetState() async {
    state = BookingState.initial();
    getBookings();
  }

  Future getBookings() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final bookings = currentState.bookingsData;
    final hasReachedMax = currentState.hasReachedMax;

    try {
      if (!hasReachedMax) {
        final result = await bookingUseCase.getAllBookings(page);
        result.fold(
          (failure) =>
              state = state.copyWith(hasReachedMax: true, isLoading: false),
          (data) async {
            bookings.clear();
            final newBookings = [...bookings, ...data];
            state = state.copyWith(
              bookingsData: newBookings,
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

  void resetMessage(bool value) {
    state = state.copyWith(isLoading: false);
  }
}
