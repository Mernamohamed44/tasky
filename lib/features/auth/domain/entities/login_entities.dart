import 'package:tasky/features/auth/data/models/login_model.dart';

class LoginEntities {
  final String sId;
  String accessToken;
  String refreshToken;

  LoginEntities(
      {required this.sId,
      required this.accessToken,
      required this.refreshToken});

  LoginModel copyWith({
    String? sid,
    String? accessToken,
    String? refreshToken,
  }) {
    return LoginModel(
      sId: sid ?? sId,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
