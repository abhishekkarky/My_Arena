import 'package:json_annotation/json_annotation.dart';
import 'package:my_arena/features/auth/domain/entity/auth_entity.dart';

part 'get_user_detail.g.dart';

@JsonSerializable()
class GetUserDetailDTO {
  final bool success;
  final String message;
  final AuthEntity userDetail;

  GetUserDetailDTO({
    required this.success,
    required this.message,
    required this.userDetail,
  });

  factory GetUserDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserDetailDTOToJson(this);
}
