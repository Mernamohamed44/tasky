import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/app/caching/shared_prefs.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/features/tasks/domin/entities/tasks_entities.dart';
import 'package:tasky/features/tasks/domin/repository/base_tasks_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this.baseTasksRepository) : super(TasksInitial());

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final SingleValueDropDownController priorityController =
      SingleValueDropDownController();
  final SingleValueDropDownController statusController =
      SingleValueDropDownController();

  //=====================================================================

  DateTime? firstDate;
  String? firstDateFormat;

  void pressDate(context) async {
    firstDate = await showDatePicker(
      context: context,
      initialDate: firstDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 360)),
      lastDate: DateTime.now().add(const Duration(days: 360)),
    );

    if (firstDate != null) {
      firstDateFormat =
          "${firstDate!.year}-${firstDate!.month}-${firstDate!.day}";
      startDateController.text = firstDateFormat.toString();
    }
    emit(UpdateFirstDateStates());
  }

  File? taskImage;
  String taskImageUploaded = "";

  Future chooseImage({
    required ImageSource source,
    required BuildContext context,
  }) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (image == null) return;

    taskImage = File(image.path);
    uploadImage();
    emit(ChooseImageState());
  }

  //===============================getAllTasks=======
  final BaseTasksRepository baseTasksRepository;
  List<TasksEntities> tasks = [];

  Color? tasksStatusColor({required String type}) {
    switch (type) {
      case 'waiting':
        return Color(0xffFFE4F2);
      case 'inProgress':
        return AppColors.palePrimary;
      case 'finished':
        return const Color(0xff0087FF).withOpacity(.4);
      default:
        return Colors.black;
    }
  }

  Color? tasksStatusTextColor({required String type}) {
    switch (type) {
      case 'waiting':
        return Colors.red;
      case 'inProgress':
        return AppColors.primary;
      case 'finished':
        return const Color(0xff0087FF);
      default:
        return Colors.black;
    }
  }

  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  Future<void> getTasks({bool loadMore = false, String status = ''}) async {
    if (loadMore) {
      if (isLoadingMore || !hasMore) return; // Prevent multiple fetches
      isLoadingMore = true;
      emit(LoadingMoreTasksState());
    } else {
      emit(GetTasksLoadingState());
    }
    final response =
        await baseTasksRepository.getTasks(page: currentPage, status: status);
    print(Caching.getUser()!.accessToken);
    response.fold(
      (l) {
        if (loadMore) {
          isLoadingMore = false;
          emit(LoadMoreTasksFailedState(message: l.message));
        } else {
          emit(GetTasksFailedState(message: l.message));
        }
      },
      (r) {
        if (loadMore) {
          tasks.addAll(r);
          isLoadingMore = false;
        } else {
          tasks = r;
        }
        hasMore = r.isNotEmpty;
        if (hasMore) currentPage++;

        if (loadMore) {
          emit(LoadMoreTasksSuccessState());
        } else {
          emit(GetTasksSuccessState());
        }
      },
    );
  }

  TasksEntities? task;

  Future<void> getOneTask({required String id}) async {
    emit(GetOneTaskLoadingState());
    final response = await baseTasksRepository.getOneTask(id: id);
    response.fold(
      (l) => emit(GetOneTaskFailedState(message: l.message)),
      (r) {
        task = r;
        emit(GetOneTaskSuccessState());
      },
    );
  }

  void refreshTasks({String status = ''}) {
    currentPage = 1;
    isLoadingMore = false;
    hasMore = true;
    tasks.clear();
    getTasks(status: status);
  }

  //====================================== add tasks
  Future<void> uploadImage() async {
    emit(UploadImageLoadingState());
    final response = await baseTasksRepository.uploadImage(image: taskImage!);
    response.fold(
      (l) => emit(UploadImageFailedState(message: l.message)),
      (r) {
        taskImageUploaded = r;
        print(taskImageUploaded);
        emit(UploadImageSuccessState());
      },
    );
  }

  Future<void> addTasks() async {
    emit(AddTasksLoadingState());
    final response = await baseTasksRepository.addTasks(
        image: taskImageUploaded,
        title: titleController.text,
        desc: descriptionController.text,
        priority: priorityController.dropDownValue!.name,
        createdAt: startDateController.text);

    response.fold(
      (l) => emit(AddTasksFailedState(message: l.message)),
      (r) {
        emit(AddTasksSuccessState());
      },
    );
  }

//////////////===edit============
  Future<void> editTasks(
      {required String user,
      required String id}) async {
    emit(EditTasksLoadingState());
    final response = await baseTasksRepository.editTasks(
        image: taskImageUploaded,
        title: titleController.text,
        desc: descriptionController.text,
        priority: priorityController.dropDownValue!.name,
        user: user,
        status:  statusController.dropDownValue!.name,
        id: id);

    response.fold(
      (l) => emit(EditTasksFailedState(message: l.message)),
      (r) {
        emit(EditTasksSuccessState());
      },
    );
  }

////=========delete==========
  Future<void> deleteTask({required String id}) async {
    emit(DeleteTasksLoadingState());
    final response = await baseTasksRepository.deleteTask(id: id);

    response.fold(
      (l) => emit(DeleteTasksFailedState(message: l.message)),
      (r) {
        emit(DeleteTasksSuccessState());
      },
    );
  }
}
