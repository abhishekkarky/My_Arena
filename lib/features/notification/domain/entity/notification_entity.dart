import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String? notificationId;
  final dynamic user;
  final dynamic booking;
  final bool? isRead;

  @override
  List<Object?> get props => [
        notificationId,
        user,
        booking,
        isRead,
      ];

  const NotificationEntity({
    this.notificationId,
    this.user,
    this.booking,
    this.isRead,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      NotificationEntity(
        notificationId: json["_id"],
        user: json["user"],
        booking: json["booking"],
        isRead: json["isRead"],
      );

  Map<String, dynamic> toJson() => {
        "_id": notificationId,
        "user": user,
        "booking": booking,
        "isRead": isRead,
      };

  @override
  String toString() {
    return 'NotificationEntity(notificationId: $notificationId, user: $user, booking: $booking, isRead:$isRead)';
  }
}
