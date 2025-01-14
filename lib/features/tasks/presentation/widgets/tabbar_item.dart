import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/app/network/end_points.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/image_manager.dart';
import 'package:tasky/app/widget/custom_alert.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/features/tasks/domin/entities/tasks_entities.dart';
import 'package:tasky/features/tasks/presentation/presentaion_logic_holder/tasks_cubit.dart';
import 'package:tasky/features/tasks/presentation/screens/edit_task_screen.dart';
import 'package:tasky/features/tasks/presentation/screens/home_screen.dart';

import '../screens/task_details_screen.dart';

class TabBarItemWidget extends StatelessWidget {
  const TabBarItemWidget({super.key, required this.tasks});

  final TasksEntities tasks;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MagicRouter.navigateTo(
            page: TaskDetailsScreen(
          taskId: tasks.sId,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(35),
                child: Image.network(
                  '${ApiConstants.baseImagesUrl}${tasks.image}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            6.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: tasks.title,
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      10.horizontalSpace,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: context
                              .read<TasksCubit>()
                              .tasksStatusColor(type: tasks.status)!,
                        ),
                        child: CustomText(
                          text: tasks.status,
                          color: context
                              .read<TasksCubit>()
                              .tasksStatusTextColor(type: tasks.status)!,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      5.horizontalSpace,
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              onTap: () {
                                MagicRouter.navigateTo(
                                    page: EditTaskScreen(
                                  image: tasks.image,
                                  title: tasks.title,
                                  desc: tasks.desc,
                                  priority: tasks.priority,
                                  date: tasks.createdAt,
                                  user: tasks.user,
                                  status: tasks.status,
                                  id: tasks.sId,
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
                                          body: 'Do You sure delete this Task?',
                                          submitWidget: BlocConsumer<TasksCubit,
                                              TasksState>(
                                            listener: (context, state) {
                                              if (state
                                                  is DeleteTasksSuccessState) {
                                                MagicRouter.navigateTo(
                                                    page: HomeView());
                                              }
                                            },
                                            builder: (context, state) {
                                              return TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<TasksCubit>()
                                                      .deleteTask(
                                                          id: tasks.sId);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: const CustomText(
                                                    text: "delete",
                                                    color: AppColors.red,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
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
                  CustomText(
                    text: tasks.desc,
                    color: AppColors.grey24252C.withOpacity(.6),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  Row(
                    children: [
                      Image.asset(ImageManager.flagIcon),
                      5.horizontalSpace,
                      CustomText(
                        text: tasks.priority,
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      CustomText(
                        text: tasks.createdAt.split("T")[0],
                        color: AppColors.grey24252C.withOpacity(.6),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
