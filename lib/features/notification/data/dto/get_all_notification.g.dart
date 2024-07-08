// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllNotificationsDTO _$GetAllNotificationsDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllNotificationsDTO(
      success: json['success'] as bool,
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => NotificationAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllNotificationsDTOToJson(
        GetAllNotificationsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'notifications': instance.notifications,
    };
