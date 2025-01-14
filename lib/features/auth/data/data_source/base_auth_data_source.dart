import 'package:tasky/features/auth/data/models/login_model.dart';
import 'package:tasky/features/auth/data/models/register_model.dart';
import 'package:tasky/features/auth/data/models/user_model.dart';

abstract class BaseRemoteAuthDataSource {
  Future<LoginModel> login({required String phone, required String password});

  Future<RegisterModel> signUp({
    required String phone,
    required String password,
    required String displayName,
    required String experienceYears,
    required String address,
    required String level,
  });

  Future<UserModel> getUserData();
}
