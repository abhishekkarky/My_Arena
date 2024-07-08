import 'package:json_annotation/json_annotation.dart';
import 'package:my_arena/features/notification/domain/entity/notification_entity.dart';

@JsonSerializable()
class NotificationAPIModel {
  @JsonKey(name: '_id')
  final String? notificationId;
  final dynamic user;
  final dynamic booking;
  final bool? isRead;

  NotificationAPIModel({
    this.notificationId,
    this.user,
    this.booking,
    this.isRead,
  });

  factory NotificationAPIModel.fromJson(Map<String, dynamic> json) {
    return NotificationAPIModel(
      notificationId: json['_id'],
      user: json['user'],
      booking: json['booking'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': notificationId,
      'user': user,
      'booking': booking,
      'isRead': isRead,
    };
  }

  factory NotificationAPIModel.fromEntity(NotificationEntity entity) {
    return NotificationAPIModel(
      notificationId: entity.notificationId,
      user: entity.user,
      booking: entity.booking,
      isRead: entity.isRead,
    );
  }

  static NotificationEntity toEntity(NotificationAPIModel model) {
    return NotificationEntity(
      notificationId: model.notificationId,
      user: model.user,
      booking: model.booking,
      isRead: model.isRead,
    );
  }
}
