import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/features/tasks/presentation/presentaion_logic_holder/tasks_cubit.dart';

import 'tabbar_item.dart';

class TabBarBodyWidget extends StatelessWidget {
  const TabBarBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    // Add a listener to the scroll controller
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        // Trigger load more when near the bottom
        context.read<TasksCubit>().getTasks(loadMore: true);
      }
    });
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TasksCubit>().refreshTasks();
      },
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is GetTasksLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (context.read<TasksCubit>().tasks.isEmpty) {
            return Center(
              child: CustomText(
                text: 'No Tasks Yet',
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
          } else if (state is GetTasksFailedState) {
            return Center(
              child: CustomText(
                text: state.message,
                color: Colors.red,
                fontSize: 16,
              ),
            );
          } else {
            final tasks = context.read<TasksCubit>().tasks;

            return ListView.builder(
              controller: scrollController,
              itemCount: tasks.length + 1,
              itemBuilder: (context, index) {
                if (index == tasks.length) {
                  if (context.read<TasksCubit>().isLoadingMore) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }

                return TabBarItemWidget(tasks: tasks[index]);
              },
            );
          }
        },
      ),
    );
  }
}
