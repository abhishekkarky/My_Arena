import 'package:json_annotation/json_annotation.dart';
import 'package:my_arena/features/bookings/domain/entity/booking_entity.dart';

@JsonSerializable()
class BookingAPIModel {
  @JsonKey(name: '_id')
  final String? bookingId;
  final dynamic futsal;
  final dynamic user;
  final dynamic vendor;
  final String? date;
  final List<dynamic>? timeSlot;
  final bool? paid;

  BookingAPIModel({
    this.bookingId,
    this.futsal,
    this.user,
    this.vendor,
    this.date,
    this.timeSlot = const [],
    this.paid,
  });

  factory BookingAPIModel.fromJson(Map<String, dynamic> json) {
    return BookingAPIModel(
      bookingId: json['_id'],
      futsal: json['futsal'],
      user: json['user'],
      vendor: json['vendor'],
      date: json['date'],
      timeSlot: json['timeSlot'],
      paid: json['paid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': bookingId,
      'futsal': futsal,
      'user': user,
      'vendor': vendor,
      'date': date,
      'timeSlot': timeSlot,
      'paid': paid,
    };
  }

  // From entity to model
  factory BookingAPIModel.fromEntity(BookingEntity entity) {
    return BookingAPIModel(
      bookingId: entity.bookingId,
      futsal: entity.futsal,
      user: entity.user,
      vendor: entity.vendor,
      date: entity.date,
      timeSlot: entity.timeSlot,
      paid: entity.paid,
    );
  }

  static BookingEntity toEntity(BookingAPIModel model) {
    return BookingEntity(
      bookingId: model.bookingId,
      futsal: model.futsal,
      user: model.user,
      vendor: model.vendor,
      date: model.date,
      timeSlot: model.timeSlot,
      paid: model.paid,
    );
  }
}
