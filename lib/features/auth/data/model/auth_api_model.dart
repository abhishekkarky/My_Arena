import 'package:json_annotation/json_annotation.dart';
import 'package:my_arena/features/auth/domain/entity/auth_entity.dart';

@JsonSerializable()
class AuthAPIModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String? userImageUrl;
  final String fullName;
  final String? email;
  final String? address;
  final String number;
  final String? country;
  final String? city;
  final String password;
  final String? userTimeZone;
  final String? otp;
  final String? otpTimestamp;
  final bool? isVerified;
  final List<dynamic>? fcmToken;
  final int? failedLoginAttempts;
  final String? role;
  final int? totalFutsals;
  final int? totalBookings;
  final bool? isBlocked;

  AuthAPIModel({
    this.userId,
    this.userImageUrl,
    required this.fullName,
    this.email,
    this.address,
    required this.number,
    required this.password,
    this.country,
    this.city,
    this.userTimeZone,
    this.fcmToken,
    this.failedLoginAttempts,
    this.role,
    this.totalFutsals,
    this.totalBookings,
    this.isBlocked,
    this.otp,
    this.otpTimestamp,
    this.isVerified,
  });

  factory AuthAPIModel.fromJson(Map<String, dynamic> json) {
    return AuthAPIModel(
      userId: json['_id'],
      userImageUrl: json['userImageUrl'],
      fullName: json['fullName'],
      email: json['email'],
      address: json['address'],
      number: json['number'],
      password: json['password'],
      country: json['country'],
      city: json['city'],
      fcmToken: json['fcmToken'],
      failedLoginAttempts: json['failedLoginAttempts'],
      role: json['role'],
      userTimeZone: json['userTimeZone'],
      totalFutsals: json['totalFutsals'],
      totalBookings: json['totalBookings'],
      isBlocked: json['isBlocked'],
      otp: json['otp'],
      otpTimestamp: json['otpTimestamp'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userImageUrl': userImageUrl,
      'fullName': fullName,
      'email': email,
      'address': address,
      'number': number,
      'password': password,
      'country': country,
      'city': city,
      'fcmToken': fcmToken,
      'failedLoginAttempts': failedLoginAttempts,
      'userTimeZone': userTimeZone,
      'role': role,
      'totalFutsals': totalFutsals,
      'totalBookings': totalBookings,
      'isBlocked': isBlocked,
      'userId': userId,
      'otp': otp,
      'otpTimestamp': otpTimestamp,
      'isVerified': isVerified
    };
  }

  // From entity to model
  factory AuthAPIModel.fromEntity(AuthEntity entity) {
    return AuthAPIModel(
      userImageUrl: entity.userImageUrl,
      fullName: entity.fullName,
      email: entity.email,
      address: entity.address,
      number: entity.number,
      password: entity.password,
      country: entity.country,
      city: entity.city,
      userTimeZone: entity.userTimeZone,
      fcmToken: entity.fcmToken,
      failedLoginAttempts: entity.failedLoginAttempts,
      role: entity.role,
      totalFutsals: entity.totalFutsals,
      totalBookings: entity.totalBookings,
      isBlocked: entity.isBlocked,
      userId: entity.userId,
      otp: entity.otp,
      otpTimestamp: entity.otpTimestamp,
      isVerified: entity.isVerified,
    );
  }

  // From model to entity
  static AuthEntity toEntity(AuthAPIModel model) {
    return AuthEntity(
        userId: model.userId,
        userImageUrl: model.userImageUrl,
        fullName: model.fullName,
        email: model.email,
        address: model.address,
        number: model.number,
        password: model.password,
        country: model.country,
        city: model.city,
        fcmToken: model.fcmToken,
        failedLoginAttempts: model.failedLoginAttempts,
        role: model.role,
        totalFutsals: model.totalFutsals,
        totalBookings: model.totalBookings,
        isBlocked: model.isBlocked,
        otp: model.otp,
        otpTimestamp: model.otpTimestamp,
        isVerified: model.isVerified);
  }
}
