import 'package:dartz/dartz.dart';
import 'package:tasky/app/errors/server_errors.dart';
import 'package:tasky/features/auth/domain/entities/login_entities.dart';
import 'package:tasky/features/auth/domain/entities/register_entities.dart';
import 'package:tasky/features/auth/domain/entities/user_entities.dart';

abstract class BaseAuthRepository {
  Future<Either<ServerError, LoginEntities>> login({
    required String phone,
    required String password,
  });

  Future<Either<ServerError, RegisterEntities>> register({
    required String phone,
    required String password,
    required String displayName,
    required String experienceYears,
    required String address,
    required String level,
  });

  Future<Either<ServerError, UserEntities>> getUserData();
}
