import 'package:tasky/features/tasks/data/models/tasks_model.dart';

class TasksEntities {
  final String sId;
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String user;
  final String createdAt;
  final String updatedAt;
  final int iV;

  TasksEntities(
      {required this.sId,
      required this.image,
      required this.title,
      required this.desc,
      required this.priority,
      required this.status,
      required this.user,
      required this.createdAt,
      required this.updatedAt,
      required this.iV});

  TasksModel copyWith({
    String? sId,
    String? image,
    String? title,
    String? desc,
    String? priority,
    String? status,
    String? user,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) {
    return TasksModel(
        sId: sId ?? this.sId,
        image: image ?? this.image,
        title: title ?? this.title,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        iV: iV ?? this.iV,
        priority: priority ?? this.priority,
        desc: desc ?? this.desc,
        status: status ?? this.status);
  }
}
