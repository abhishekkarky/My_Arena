import 'package:json_annotation/json_annotation.dart';
import 'package:my_arena/features/discover/domain/entity/futsal_entity.dart';

@JsonSerializable()
class FutsalAPIModel {
  @JsonKey(name: '_id')
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

  FutsalAPIModel({
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

  factory FutsalAPIModel.fromJson(Map<String, dynamic> json) {
    return FutsalAPIModel(
      futsalId: json['_id'],
      futsalImageUrl: json['futsalImageUrl'],
      name: json['name'],
      location: json['location'],
      rating: json['rating'],
      groundSize: json['groundSize'],
      price: json['price'],
      lat: json['lat'],
      long: json['long'],
      timeSlots: json['timeSlots'],
      dayOfWeek: json['dayOfWeek'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': futsalId,
      'futsalImageUrl': futsalImageUrl,
      'name': name,
      'location': location,
      'rating': rating,
      'groundSize': groundSize,
      'price': price,
      'lat': lat,
      'long': long,
      'timeSlots': timeSlots,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  // From entity to model
  factory FutsalAPIModel.fromEntity(FutsalEntity entity) {
    return FutsalAPIModel(
      futsalId: entity.futsalId,
      futsalImageUrl: entity.futsalImageUrl,
      name: entity.name,
      location: entity.location,
      rating: entity.rating,
      groundSize: entity.groundSize,
      price: entity.price,
      lat: entity.lat,
      long: entity.long,
      timeSlots: entity.timeSlots,
      dayOfWeek: entity.dayOfWeek,
      startTime: entity.startTime,
      endTime: entity.endTime,
    );
  }

  static FutsalEntity toEntity(FutsalAPIModel model) {
    return FutsalEntity(
      futsalId: model.futsalId,
      futsalImageUrl: model.futsalImageUrl,
      name: model.name,
      location: model.location,
      rating: model.rating,
      groundSize: model.groundSize,
      price: model.price,
      lat: model.lat,
      long: model.long,
      timeSlots: model.timeSlots,
      dayOfWeek: model.dayOfWeek,
      startTime: model.startTime,
      endTime: model.endTime,
    );
  }
}
