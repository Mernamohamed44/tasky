import 'package:dio/dio.dart';
import 'package:tasky/app/caching/shared_prefs.dart';
import 'package:tasky/app/network/dio.dart';
import 'package:tasky/features/auth/data/data_source/base_auth_data_source.dart';
import 'package:tasky/features/auth/data/models/login_model.dart';
import 'package:tasky/features/auth/data/models/register_model.dart';
import 'package:tasky/features/auth/data/models/user_model.dart';

import '../../../../app/network/end_points.dart';

class RemoteAuthDataSource extends BaseRemoteAuthDataSource {
  final dioManager = DioManager();

  @override
  Future<LoginModel> login(
      {required String phone, required String password}) async {
    final Response response = await dioManager.post(
      ApiConstants.login,
      data: {
        "phone": phone,
        "password": password,
      },
    );
    return LoginModel.fromJson(response.data);
  }

  @override
  Future<RegisterModel> signUp({
    required String phone,
    required String password,
    required String displayName,
    required String experienceYears,
    required String address,
    required String level,
  }) async {
    final Response response = await dioManager.post(
      ApiConstants.register,
      data: {
        "phone": phone,
        "password": password,
        "displayName": displayName,
        "experienceYears": experienceYears,
        "address": address,
        "level": level,
      },
    );
    return RegisterModel.fromJson(response.data);
  }

  @override
  Future<UserModel> getUserData() async {
    final Response response = await dioManager.get(ApiConstants.profile,
        header: {'Authorization': "Bearer ${Caching.getUser()!.accessToken}"});
    return UserModel.fromJson(response.data);
  }
}
