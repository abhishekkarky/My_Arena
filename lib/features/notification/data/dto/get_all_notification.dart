import 'package:json_annotation/json_annotation.dart';
import 'package:my_arena/features/notification/data/model/notification_api_model.dart';

part 'get_all_notification.g.dart';

@JsonSerializable()
class GetAllNotificationsDTO {
  final bool success;
  final List<NotificationAPIModel> notifications;

  GetAllNotificationsDTO({required this.success, required this.notifications});

  factory GetAllNotificationsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllNotificationsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllNotificationsDTOToJson(this);

  static GetAllNotificationsDTO toEntity(
      GetAllNotificationsDTO getAllNotificationsDTO) {
    return GetAllNotificationsDTO(
      success: getAllNotificationsDTO.success,
      notifications: getAllNotificationsDTO.notifications,
    );
  }

  static GetAllNotificationsDTO fromEntity(
      GetAllNotificationsDTO getAllNotificationsDTO) {
    return GetAllNotificationsDTO(
      success: getAllNotificationsDTO.success,
      notifications: getAllNotificationsDTO.notifications,
    );
  }
}
