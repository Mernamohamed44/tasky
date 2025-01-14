import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/app/errors/server_errors.dart';
import 'package:tasky/features/auth/data/data_source/base_auth_data_source.dart';
import 'package:tasky/features/auth/domain/entities/login_entities.dart';
import 'package:tasky/features/auth/domain/entities/register_entities.dart';
import 'package:tasky/features/auth/domain/entities/user_entities.dart';
import 'package:tasky/features/auth/domain/repository/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseRemoteAuthDataSource dataSource;

  AuthRepository(this.dataSource);

  @override
  Future<Either<ServerError, LoginEntities>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final result = await dataSource.login(
        phone: phone,
        password: password,
      );
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, RegisterEntities>> register(
      {required String phone,
      required String password,
      required String displayName,
      required String experienceYears,
      required String address,
      required String level}) async {
    try {
      final result = await dataSource.signUp(
        phone: phone,
        password: password,
        displayName: displayName,
        experienceYears: experienceYears,
        address: address,
        level: level,
      );
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, UserEntities>> getUserData() async {
    try {
      final result = await dataSource.getUserData();
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }
}
