part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class ChangeNumberState extends AuthState {}

class ChanceVisibilityState extends AuthState {}

class LogInLoadingState extends AuthState {}

class LogInFailState extends AuthState {
  final String message;

  LogInFailState({required this.message});
}

class LogInSuccessState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterFailState extends AuthState {
  final String message;

  RegisterFailState({required this.message});
}

class RegisterSuccessState extends AuthState {}

class UserDataLoadingState extends AuthState {}

class UserDataFailState extends AuthState {
  final String message;

  UserDataFailState({required this.message});
}

class UserDataSuccessState extends AuthState {}
