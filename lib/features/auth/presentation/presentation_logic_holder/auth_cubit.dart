import 'package:bloc/bloc.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:logger/web.dart';
import 'package:tasky/app/caching/shared_prefs.dart';
import 'package:tasky/features/auth/data/models/register_model.dart';
import 'package:tasky/features/auth/domain/entities/user_entities.dart';
import 'package:tasky/features/auth/domain/repository/base_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final BaseAuthRepository repo;

  AuthCubit(this.repo) : super(AuthInitial());
  String phoneNumber = "";
  String number = "";

  onInputChanged(PhoneNumber phone) {
    phoneNumber = "${phone.countryCode}${phone.number}";
    number = phone.number;
    emit(ChangeNumberState());
  }

  bool isObscure = true;

  changeVisibility() {
    isObscure = !isObscure;
    emit(ChanceVisibilityState());
  }

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  SingleValueDropDownController levelController =
      SingleValueDropDownController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Future login() async {
    if (loginFormKey.currentState!.validate()) {
      print('printttt');
      emit(LogInLoadingState());
      final response = await repo.login(
        phone: phoneNumber,
        password: passwordController.text,
      );
      response.fold(
        (l) {
          emit(LogInFailState(message: l.message));
          Logger().e(l.message);
        },
        (r) async {
          await Caching.setUser(
            RegisterModel(
              sId: r.sId,
              displayName: '',
              accessToken: r.accessToken,
              refreshToken: r.refreshToken,
            ),
          );
          Caching.put(key: 'access_token', value: r.accessToken);
          Caching.put(key: 'refresh_token', value: r.refreshToken);
          emit(LogInSuccessState());
        },
      );
    }
  }

  Future register() async {
    if (registerFormKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      final response = await repo.register(
        phone: phoneNumber,
        password: passwordController.text,
        displayName: nameController.text,
        experienceYears: yearController.text,
        address: addressController.text,
        level: levelController.dropDownValue!.name,
      );
      response.fold(
        (l) {
          emit(RegisterFailState(message: l.message));
          Logger().e(l.message);
        },
        (r) async {
          await Caching.setUser(
            RegisterModel(
              sId: r.sId,
              displayName: r.displayName,
              accessToken: r.accessToken,
              refreshToken: r.refreshToken,
            ),
          );
          Caching.put(key: 'access_token', value: r.accessToken);
          Caching.put(key: 'refresh_token', value: r.refreshToken);
          emit(RegisterSuccessState());
        },
      );
    }
  }

  UserEntities? user;

  Future getUserData() async {
    emit(UserDataLoadingState());
    final response = await repo.getUserData();
    response.fold(
      (l) {
        emit(UserDataFailState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        user = r;

        emit(UserDataSuccessState());
      },
    );
  }
}
