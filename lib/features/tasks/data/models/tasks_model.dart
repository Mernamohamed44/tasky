import 'package:tasky/features/tasks/domin/entities/tasks_entities.dart';

class TasksModel extends TasksEntities {
  TasksModel(
      {required super.sId,
      required super.image,
      required super.title,
      required super.desc,
      required super.priority,
      required super.status,
      required super.user,
      required super.createdAt,
      required super.updatedAt,
      required super.iV});

  factory TasksModel.fromJson(Map<String, dynamic> json) {
    return TasksModel(
        sId: json['_id'],
        image: json['image'],
        title: json['title'],
        desc: json['desc'],
        priority: json['priority'],
        status: json['status'],
        user: json['user'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        iV: json['__v']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
