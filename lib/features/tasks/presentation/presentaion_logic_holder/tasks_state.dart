part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class UpdateFirstDateStates extends TasksState {}

class ChooseImageState extends TasksState {}

class GetTasksLoadingState extends TasksState {}

class GetTasksFailedState extends TasksState {
  final String message;

  GetTasksFailedState({required this.message});
}

class GetTasksSuccessState extends TasksState {}

class GetOneTaskLoadingState extends TasksState {}

class GetOneTaskFailedState extends TasksState {
  final String message;

  GetOneTaskFailedState({required this.message});
}

class GetOneTaskSuccessState extends TasksState {}

class UploadImageLoadingState extends TasksState {}

class UploadImageFailedState extends TasksState {
  final String message;

  UploadImageFailedState({required this.message});
}

class UploadImageSuccessState extends TasksState {}

class AddTasksLoadingState extends TasksState {}

class AddTasksFailedState extends TasksState {
  final String message;

  AddTasksFailedState({required this.message});
}

class AddTasksSuccessState extends TasksState {}

class EditTasksLoadingState extends TasksState {}

class EditTasksFailedState extends TasksState {
  final String message;

  EditTasksFailedState({required this.message});
}

class EditTasksSuccessState extends TasksState {}

class DeleteTasksLoadingState extends TasksState {}

class DeleteTasksFailedState extends TasksState {
  final String message;

  DeleteTasksFailedState({required this.message});
}

class DeleteTasksSuccessState extends TasksState {}

class LoadingMoreTasksState extends TasksState {}

class LoadMoreTasksSuccessState extends TasksState {}

class LoadMoreTasksFailedState extends TasksState {
  final String message;

  LoadMoreTasksFailedState({required this.message});
}
