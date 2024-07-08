import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/bookings/data/repository/booking_remote_repository.dart';
import 'package:my_arena/features/bookings/domain/entity/booking_entity.dart';

final bookingRepositoryProvider = Provider.autoDispose<IBookingRepository>(
  (ref) {
    return ref.read(bookingRemoteRepositoryProvider);
  },
);

abstract class IBookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getAllBookings(int page);
}
