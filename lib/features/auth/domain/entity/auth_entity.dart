import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
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

  @override
  List<Object?> get props => [
        userId,
        userImageUrl,
        fullName,
        email,
        address,
        number,
        country,
        city,
        userTimeZone,
        fcmToken,
        failedLoginAttempts,
        role,
        totalFutsals,
        totalBookings,
        isBlocked,
        password,
        otp,
        otpTimestamp,
        isVerified,
      ];

  const AuthEntity({
    this.userId,
    this.userImageUrl,
    required this.fullName,
    this.email,
    this.address,
    required this.number,
    this.country,
    this.city,
    this.fcmToken,
    this.userTimeZone,
    this.failedLoginAttempts,
    this.role,
    this.totalFutsals,
    this.totalBookings,
    this.isBlocked,
    required this.password,
    this.otp,
    this.otpTimestamp,
    this.isVerified,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => AuthEntity(
      userId: json["userId"],
      userImageUrl: json['userImageUrl'],
      fullName: json["fullName"],
      email: json["email"],
      address: json['address'],
      number: json['number'],
      country: json['country'],
      city: json['city'],
      userTimeZone: json['userTimeZone'],
      fcmToken: json['fcmToken'] as List<dynamic>?,
      failedLoginAttempts: json['failedLoginAttempts'],
      role: json['role'],
      totalFutsals: json['totalFutsals'],
      totalBookings: json['totalBookings'],
      isBlocked: json['isBlocked'],
      password: json["password"],
      otp: json['otp'],
      otpTimestamp: json['otpTimestamp'],
      isVerified: json['isVerified']);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userImageUrl": userImageUrl,
        "fullName": fullName,
        "email": email,
        "address": address,
        "number": number,
        "country": country,
        "city": city,
        "fcmToken": fcmToken,
        "userTimeZone": userTimeZone,
        "failedLoginAttempts": failedLoginAttempts,
        "role": role,
        "totalFutsals": totalFutsals,
        "totalBookings": totalBookings,
        "isBlocked": isBlocked,
        "password": password,
        "otp": otp,
        "otpTimestamp": otpTimestamp,
        "isVerified": isVerified,
      };

  @override
  String toString() {
    return 'AuthEntity(userId: $userId, userImageUrl: $userImageUrl, fullName: $fullName, email: $email, address: $address, number: $number, password: $password, otp: $otp, otpTimestamp: $otpTimestamp, isVerified: $isVerified)';
  }
}
