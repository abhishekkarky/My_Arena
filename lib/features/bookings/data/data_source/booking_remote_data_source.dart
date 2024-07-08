import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/config/constants/api_endpoints.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/core/network/http_service.dart';
import 'package:my_arena/core/shared_prefs/user_shared_prefs.dart';
import 'package:my_arena/features/bookings/data/dto/get_all_bookings.dart';
import 'package:my_arena/features/bookings/data/model/booking_model.dart';
import 'package:my_arena/features/bookings/domain/entity/booking_entity.dart';

final bookingRemoteDataSourceProvider =
    Provider.autoDispose<BookingRemoteDataSource>(
  (ref) => BookingRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class BookingRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  BookingRemoteDataSource(
      {required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, List<BookingEntity>>> getAllBookings(
      int page) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);
      var response = await dio.get(
        ApiEndpoints.getAllBookings,
        queryParameters: {
          'page': page,
          'limit': ApiEndpoints.limitPage,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllBookingDTO? getAllBookingDTO =
            GetAllBookingDTO.fromJson(response.data);

        List<BookingEntity> bookingList = getAllBookingDTO.bookingsData
            .map((booking) => BookingAPIModel.toEntity(booking))
            .toList();

        return Right(bookingList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage?.toString() ?? 'Unknown error',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message']?.toString() ?? 'An error occurred';
      return Left(Failure(error: errorMessage));
    }
  }
}
