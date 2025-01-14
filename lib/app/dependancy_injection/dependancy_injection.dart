import 'package:get_it/get_it.dart';
import 'package:tasky/features/auth/data/data_source/base_auth_data_source.dart';
import 'package:tasky/features/auth/data/data_source/remote_auth_data_source.dart';
import 'package:tasky/features/auth/data/repo/auth_repository.dart';
import 'package:tasky/features/auth/domain/repository/base_auth_repository.dart';
import 'package:tasky/features/auth/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:tasky/features/tasks/data/data_source/base_tasks_data_source.dart';
import 'package:tasky/features/tasks/data/data_source/remote_tasks_data_source.dart';
import 'package:tasky/features/tasks/data/repo/tasks_repository.dart';
import 'package:tasky/features/tasks/domin/repository/base_tasks_repository.dart';
import 'package:tasky/features/tasks/presentation/presentaion_logic_holder/tasks_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<BaseRemoteAuthDataSource>(
      () => RemoteAuthDataSource());
  getIt
      .registerLazySingleton<BaseAuthRepository>(() => AuthRepository(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

  ///////////////////////////////////////
  getIt.registerLazySingleton<BaseRemoteTasksDataSource>(
      () => RemoteTasksDataSource());
  getIt.registerLazySingleton<BaseTasksRepository>(
      () => TasksRepository(getIt()));
  getIt.registerFactory<TasksCubit>(() => TasksCubit(getIt()));
}
