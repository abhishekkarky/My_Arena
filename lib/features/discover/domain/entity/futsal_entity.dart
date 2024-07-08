import 'package:equatable/equatable.dart';

class FutsalEntity extends Equatable {
  final String? futsalId;
  final String? futsalImageUrl;
  final String? name;
  final String? location;
  final int? rating;
  final String? groundSize;
  final int? price;
  final int? lat;
  final int? long;
  final List<dynamic>? timeSlots;
  final List<dynamic>? dayOfWeek;
  final String? startTime;
  final String? endTime;

  @override
  List<Object?> get props => [
        futsalId,
        futsalImageUrl,
        name,
        location,
        rating,
        groundSize,
        price,
        lat,
        long,
        timeSlots,
        dayOfWeek,
        startTime,
        endTime,
      ];

  const FutsalEntity({
    this.futsalId,
    this.futsalImageUrl,
    this.name,
    this.location,
    this.rating,
    this.groundSize,
    this.price,
    this.lat,
    this.long,
    this.timeSlots,
    this.dayOfWeek,
    this.startTime,
    this.endTime,
  });

  factory FutsalEntity.fromJson(Map<String, dynamic> json) => FutsalEntity(
        futsalId: json["_id"],
        futsalImageUrl: json["futsalImageUrl"],
        name: json["name"],
        location: json["location"],
        rating: json["rating"],
        groundSize: json["groundSize"],
        price: json["price"],
        lat: json["lat"],
        long: json["long"],
        timeSlots: json["timeSlots"],
        dayOfWeek: json["dayOfWeek"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "_id": futsalId,
        "futsalImageUrl": futsalImageUrl,
        "name": name,
        "location": location,
        "rating": rating,
        "groundSize": groundSize,
        "price": price,
        "lat": lat,
        "long": long,
        "timeSlots": timeSlots,
        "dayOfWeek": dayOfWeek,
        "startTime": startTime,
        "endTime": endTime,
      };

  @override
  String toString() {
    return 'FutsalEntity(futsalId: $futsalId)';
  }
}
