import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/app/errors/server_errors.dart';
import 'package:tasky/features/tasks/data/data_source/base_tasks_data_source.dart';
import 'package:tasky/features/tasks/domin/entities/tasks_entities.dart';
import 'package:tasky/features/tasks/domin/repository/base_tasks_repository.dart';

class TasksRepository extends BaseTasksRepository {
  final BaseRemoteTasksDataSource dataSource;

  TasksRepository(this.dataSource);

  @override
  Future<Either<ServerError, List<TasksEntities>>> getTasks(
      {required int page, required String status}) async {
    try {
      final result = await dataSource.getAllTasks(page: page, status: status);
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, void>> addTasks({
    required image,
    required title,
    required desc,
    required priority,
    required createdAt,
  }) async {
    try {
      await dataSource.addTask(
          image: image,
          title: title,
          desc: desc,
          priority: priority,
          createdAt: createdAt);
      return const Right('_r');
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, String>> uploadImage({required File image}) async {
    try {
      final result = await dataSource.uploadImage(image: image);
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, void>> editTasks(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String user,
      required String status,
      required String id}) async {
    try {
      await dataSource.editTask(
          image: image,
          title: title,
          desc: desc,
          priority: priority,
          user: user,
          status: status,
          id: id);
      return const Right('_r');
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, void>> deleteTask({required String id}) async {
    try {
      await dataSource.deleteTask(id: id);
      return const Right('_r');
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, TasksEntities>> getOneTask(
      {required String id}) async {
    try {
      final result = await dataSource.getOneTask(id: id);
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }
}
