import 'package:json_annotation/json_annotation.dart';
import 'package:my_arena/features/bookings/data/model/booking_model.dart';

part 'get_all_bookings.g.dart';

@JsonSerializable()
class GetAllBookingDTO {
  final bool success;
  final List<BookingAPIModel> bookingsData;

  GetAllBookingDTO({required this.success, required this.bookingsData});

  factory GetAllBookingDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllBookingDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllBookingDTOToJson(this);

  static GetAllBookingDTO toEntity(
      GetAllBookingDTO getAllBookingDTO) {
    return GetAllBookingDTO(
      success: getAllBookingDTO.success,
      bookingsData: getAllBookingDTO.bookingsData,
    );
  }

  static GetAllBookingDTO fromEntity(
      GetAllBookingDTO getAllBookingDTO) {
    return GetAllBookingDTO(
      success: getAllBookingDTO.success,
      bookingsData: getAllBookingDTO.bookingsData,
    );
  }
}
