import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:tasky/app/caching/shared_prefs.dart';
import 'package:tasky/app/network/dio.dart';
import 'package:tasky/app/network/end_points.dart';
import 'package:tasky/features/tasks/data/data_source/base_tasks_data_source.dart';
import 'package:tasky/features/tasks/data/models/tasks_model.dart';

class RemoteTasksDataSource extends BaseRemoteTasksDataSource {
  final dioManager = DioManager();

  @override
  Future<List<TasksModel>> getAllTasks(
      {required int page, required String status}) async {
    final response = await dioManager.get(ApiConstants.tasks, queryParameters: {
      'page': page,
      if (status.isNotEmpty) 'status': status
    }, header: {
      'Authorization': "Bearer ${Caching.getUser()!.accessToken}"
    });
    return List<TasksModel>.from(
      response.data.map(
        (e) => TasksModel.fromJson(e),
      ),
    );
  }

  @override
  Future<void> addTask({
    required image,
    required title,
    required desc,
    required priority,
    required createdAt,
  }) async {
    await dioManager.post(
      ApiConstants.addTasks,
      header: {'Authorization': "Bearer ${Caching.getUser()!.accessToken}"},
      data: {
        "image": image,
        "title": title,
        "desc": desc,
        "priority": priority,
      },
    );
  }

  @override
  Future<String> uploadImage({required File image}) async {
    final Response response = await dioManager.post(ApiConstants.uploadImage,
        header: {'Authorization': "Bearer ${Caching.getUser()!.accessToken}"},
        data: FormData.fromMap({
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            contentType: MediaType('image', image.path.split('.').last),
          ),
        }));
    return response.data['image'];
  }

  @override
  Future<void> editTask(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String status,
      required String user,
      required String id}) async {
    await dioManager.put(
      '${ApiConstants.oneTask}$id',
      header: {'Authorization': "Bearer ${Caching.getUser()!.accessToken}"},
      data: {
        "image": image,
        "title": title,
        "desc": desc,
        "priority": priority,
        "status": status,
        "user": user,
      },
    );
  }

  @override
  Future<void> deleteTask({required String id}) async {
    await dioManager.delete(
      '${ApiConstants.deleteTasks}$id',
      header: {'Authorization': "Bearer ${Caching.getUser()!.accessToken}"},
    );
  }

  @override
  Future<TasksModel> getOneTask({required String id}) async {
    final response = await dioManager.get('${ApiConstants.oneTask}$id',
        header: {'Authorization': "Bearer ${Caching.getUser()!.accessToken}"});
    return TasksModel.fromJson(response.data);
  }
}
