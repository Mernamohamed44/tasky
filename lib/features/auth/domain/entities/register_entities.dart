import 'package:tasky/features/auth/data/models/register_model.dart';

class RegisterEntities {
  final String? sId;
  final String? displayName;
  late final String? accessToken;
  final String? refreshToken;

  RegisterEntities(
      {required this.sId,
      required this.displayName,
      required this.accessToken,
      required this.refreshToken});

  RegisterModel copyWith({
    String? sid,
    String? displayName,
    String? accessToken,
    String? refreshToken,
  }) {
    return RegisterModel(
      sId: sid ?? sId,
      displayName: displayName ?? sId,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
