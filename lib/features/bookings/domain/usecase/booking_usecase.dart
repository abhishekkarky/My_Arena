import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/bookings/domain/entity/booking_entity.dart';
import 'package:my_arena/features/bookings/domain/repository/booking_repository.dart';

final bookingUseCaseProvider = Provider.autoDispose<BookingUseCase>(
    (ref) =>
        BookingUseCase(repository: ref.read(bookingRepositoryProvider)));

class BookingUseCase {
  final IBookingRepository repository;

  BookingUseCase({required this.repository});

  Future<Either<Failure, List<BookingEntity>>> getAllBookings(
      int page) async {
    return await repository.getAllBookings(page);
  }
}
