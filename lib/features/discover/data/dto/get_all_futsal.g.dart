// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_futsal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllFutsalDTO _$GetAllFutsalDTOFromJson(Map<String, dynamic> json) =>
    GetAllFutsalDTO(
      success: json['success'] as bool,
      futsals: (json['futsals'] as List<dynamic>)
          .map((e) => FutsalAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllFutsalDTOToJson(GetAllFutsalDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'futsals': instance.futsals,
    };
