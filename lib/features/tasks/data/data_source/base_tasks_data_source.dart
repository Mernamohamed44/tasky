import 'dart:io';

import 'package:tasky/features/tasks/data/models/tasks_model.dart';

abstract class BaseRemoteTasksDataSource {
  Future<List<TasksModel>> getAllTasks(
      {required int page, required String status});

  Future<TasksModel> getOneTask({required String id});

  Future<void> addTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String createdAt,
  });

  Future<void> editTask(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String status,
      required String user,
      required String id});

  Future<void> deleteTask({required String id});

  Future<String> uploadImage({
    required File image,
  });
}
