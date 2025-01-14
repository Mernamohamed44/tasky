import 'package:tasky/features/auth/domain/entities/register_entities.dart';

class RegisterModel extends RegisterEntities {
  RegisterModel(
      {required super.sId,
      required super.displayName,
      required super.accessToken,
      required super.refreshToken});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      sId: json['_id'],
      displayName: json['_id'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['displayName'] = displayName;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
