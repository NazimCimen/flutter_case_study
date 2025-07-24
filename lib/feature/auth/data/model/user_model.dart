import 'package:case_study/feature/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
final class UserModel extends UserEntity {
  final String? token;
  const UserModel({super.id, super.name, super.email, super.photoUrl, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() => UserEntity(
    id: id ?? '',
    name: name ?? '',
    email: email ?? '',
    photoUrl: photoUrl ?? '',
  );
}
