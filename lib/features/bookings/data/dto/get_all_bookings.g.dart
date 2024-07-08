// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_bookings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllBookingDTO _$GetAllBookingDTOFromJson(Map<String, dynamic> json) =>
    GetAllBookingDTO(
      success: json['success'] as bool,
      bookingsData: (json['bookingsData'] as List<dynamic>)
          .map((e) => BookingAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllBookingDTOToJson(GetAllBookingDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'bookingsData': instance.bookingsData,
    };
