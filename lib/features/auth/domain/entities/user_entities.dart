import 'package:tasky/features/auth/data/models/user_model.dart';

abstract class UserEntities {
  String? sId;
  String? displayName;
  String? username;
  List<dynamic>? roles;
  bool? active;
  int? experienceYears;
  String? address;
  String? level;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserEntities(
      {this.sId,
      this.displayName,
      this.username,
      this.roles,
      this.active,
      this.experienceYears,
      this.address,
      this.level,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserModel copyWith({
    String? sId,
    String? displayName,
    String? username,
    List<dynamic>? roles,
    bool? active,
    int? experienceYears,
    String? address,
    String? level,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) {
    return UserModel(
      sId: sId ?? this.sId,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      roles: roles ?? this.roles,
      active: active ?? this.active,
      experienceYears: experienceYears ?? this.experienceYears,
      address: address ?? this.address,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      iV: iV ?? this.iV,
    );
  }
}
