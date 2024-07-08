import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/bookings/data/data_source/booking_remote_data_source.dart';
import 'package:my_arena/features/bookings/domain/entity/booking_entity.dart';
import 'package:my_arena/features/bookings/domain/repository/booking_repository.dart';

final bookingRemoteRepositoryProvider =
    Provider.autoDispose<BookingRemoteRepoImpl>(
  (ref) => BookingRemoteRepoImpl(
    bookingRemoteDataSource: ref.read(bookingRemoteDataSourceProvider),
  ),
);

class BookingRemoteRepoImpl implements IBookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;

  BookingRemoteRepoImpl(
      {required this.bookingRemoteDataSource});

  @override
  Future<Either<Failure, List<BookingEntity>>> getAllBookings(int page) {
    return bookingRemoteDataSource.getAllBookings(page);
  }
}
