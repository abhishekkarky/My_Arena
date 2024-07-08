import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String? bookingId;
  final dynamic futsal;
  final dynamic user;
  final dynamic vendor;
  final String? date;
  final List<dynamic>? timeSlot;
  final bool? paid;

  @override
  List<Object?> get props => [
        bookingId,
        futsal,
        user,
        vendor,
        date,
        timeSlot,
        paid,
      ];

  const BookingEntity({
    this.bookingId,
    this.futsal,
    this.user,
    this.vendor,
    required this.date,
    this.timeSlot,
    this.paid,
  });

  factory BookingEntity.fromJson(Map<String, dynamic> json) => BookingEntity(
        bookingId: json["_id"],
        futsal: json["futsal"],
        user: json["user"],
        vendor: json["vendor"],
        date: json["date"],
        timeSlot: json["timeSlot"],
        paid: json["paid"],
      );

  Map<String, dynamic> toJson() => {
        "_id": bookingId,
        "futsal": futsal,
        "user": user,
        "vendor": vendor,
        "date": date,
        "timeSlot": timeSlot,
      };

  @override
  String toString() {
    return 'BookingEntity(bookingId: $bookingId, user: $user, vendor:$vendor, date:$date, paid:$paid)';
  }
}
