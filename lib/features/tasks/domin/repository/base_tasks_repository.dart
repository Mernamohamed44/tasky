import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/features/tasks/domin/entities/tasks_entities.dart';

import '../../../../app/errors/server_errors.dart';

abstract class BaseTasksRepository {
  Future<Either<ServerError, List<TasksEntities>>> getTasks(
      {required int page, required String status});

  Future<Either<ServerError, TasksEntities>> getOneTask({required String id});

  Future<Either<ServerError, void>> addTasks({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String createdAt,
  });

  Future<Either<ServerError, void>> editTasks(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String user,
      required String status,
      required String id});

  Future<Either<ServerError, void>> deleteTask({required String id});

  Future<Either<ServerError, String>> uploadImage({
    required File image,
  });
}
