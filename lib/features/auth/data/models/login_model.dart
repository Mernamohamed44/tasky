import 'package:tasky/features/auth/domain/entities/login_entities.dart';

class LoginModel extends LoginEntities {
  LoginModel(
      {required super.sId,
      required super.accessToken,
      required super.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      sId: json['_id'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
