import 'package:tasky/features/auth/domain/entities/user_entities.dart';

class UserModel extends UserEntities {
  UserModel(
      {required super.sId,
      required super.displayName,
      required super.username,
      required super.roles,
      required super.active,
      required super.experienceYears,
      required super.address,
      required super.level,
      required super.createdAt,
      required super.updatedAt,
      required super.iV});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        sId: json['_id'],
        displayName: json['displayName'],
        address: json['address'],
        username: json['username'],
        experienceYears: json['experienceYears'],
        createdAt: json['createdAt'],
        active: json['active'],
        level: json['level'],
        roles: json['roles'],
        iV: json['iV'],
        updatedAt: json['updatedAt']);
  }
}
