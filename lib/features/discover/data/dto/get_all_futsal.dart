import 'package:json_annotation/json_annotation.dart';
import 'package:my_arena/features/discover/data/model/futsal_model.dart';

part 'get_all_futsal.g.dart';

@JsonSerializable()
class GetAllFutsalDTO {
  final bool success;
  final List<FutsalAPIModel> futsals;

  GetAllFutsalDTO({required this.success, required this.futsals});

  factory GetAllFutsalDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllFutsalDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFutsalDTOToJson(this);

  static GetAllFutsalDTO toEntity(
      GetAllFutsalDTO getAllFutsalDTO) {
    return GetAllFutsalDTO(
      success: getAllFutsalDTO.success,
      futsals: getAllFutsalDTO.futsals,
    );
  }

  static GetAllFutsalDTO fromEntity(
      GetAllFutsalDTO getAllFutsalDTO) {
    return GetAllFutsalDTO(
      success: getAllFutsalDTO.success,
      futsals: getAllFutsalDTO.futsals,
    );
  }
}
