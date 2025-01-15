import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/app/dependancy_injection/dependancy_injection.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/app/network/end_points.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/image_manager.dart';
import 'package:tasky/app/widget/custom_alert.dart';
import 'package:tasky/app/widget/custom_cached_image.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/features/tasks/presentation/presentaion_logic_holder/tasks_cubit.dart';
import 'package:tasky/features/tasks/presentation/screens/edit_task_screen.dart';
import 'package:tasky/features/tasks/presentation/screens/home_screen.dart';

import '../widgets/details_container_widget.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(getIt())..getOneTask(id: taskId),
      child: TaskDetailsBody(
        taskId: taskId,
      ),
    );
  }
}

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is GetOneTaskLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (state is GetOneTaskFailedState) {
            return Center(
                child: CustomText(
              text: state.message,
              color: AppColors.red,
              maxLines: 4,
            ));
          }
          var task = context.read<TasksCubit>().task;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 15, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      MagicRouter.navigatePop();
                    },
                    child: Row(
                      children: [
                        Transform.rotate(
                            angle: 3.17,
                            child: Image.asset(
                              ImageManager.arrowLeft,
                              color: AppColors.black,
                            )),
                        10.horizontalSpace,
                        const CustomText(
                          text: 'Task Details',
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        const Spacer(),
                        PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                onTap: () {
                                  MagicRouter.navigateTo(
                                      page: EditTaskScreen(
                                    image: task!.image,
                                    title: task.title,
                                    desc: task.desc,
                                    priority: task.priority,
                                    date: task.createdAt,
                                    user: task.user,
                                    status: task.status,
                                    id: task.sId,
                                  ));
                                },
                                child: CustomText(
                                  text: 'Edit',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.black,
                                ),
                              ),
                              PopupMenuItem(
                                child: CustomText(
                                  text: 'Delete',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.red,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (c) {
                                        return BlocProvider.value(
                                          value: context.read<TasksCubit>(),
                                          child: CustomAlert(
                                            title: ' delete Task',
                                            body:
                                                'Do You sure delete this Task?',
                                            submitWidget: BlocConsumer<
                                                TasksCubit, TasksState>(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteTasksSuccessState) {
                                                  MagicRouter.navigateTo(
                                                      page: HomeView(),
                                                      withHistory: false);
                                                }
                                              },
                                              builder: (context, state) {
                                                return TextButton(
                                                  onPressed: () {
                                                    context
                                                        .read<TasksCubit>()
                                                        .deleteTask(
                                                            id: task!.sId);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w),
                                                    child: const CustomText(
                                                      text: "delete",
                                                      color: AppColors.red,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ];
                          },
                          child: Image.asset(ImageManager.dottedIcon),
                        )
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  Center(
                    child: CustomCachedImage(
                      fit: BoxFit.cover,
                      image: '${ApiConstants.baseImagesUrl}${task!.image}',
                    ),
                  ),
                  15.verticalSpace,
                  CustomText(
                    text: task.title,
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  10.verticalSpace,
                  CustomText(
                    text: task.desc,
                    color: AppColors.grey24252C.withOpacity(.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    maxLines: 7,
                  ),
                  20.verticalSpace,
                  DetailsContainerWidget(
                    head: 'End Date',
                    text: task.createdAt.split('T')[0],
                    icon: Icons.date_range_rounded,
                  ),
                  10.verticalSpace,
                  DetailsContainerWidget(
                    text: task.status,
                    icon: Icons.arrow_drop_down_outlined,
                  ),
                  10.verticalSpace,
                  DetailsContainerWidget(
                    text: task.priority,
                    icon: Icons.arrow_drop_down_outlined,
                    image: ImageManager.flagIcon,
                  ),
                  20.verticalSpace,
                  Center(
                    child: QrImageView(
                      data: task.sId,
                      size: 300.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
