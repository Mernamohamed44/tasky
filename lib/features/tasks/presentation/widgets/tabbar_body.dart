import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/tasks/presentation/presentaion_logic_holder/tasks_cubit.dart';

import 'tabbar_item.dart';

class TabBarBodyWidget extends StatelessWidget {
  const TabBarBodyWidget({super.key,});


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
          if (state is GetTasksLoadingState &&
              context.read<TasksCubit>().tasks.isEmpty) {
            // Show a loading indicator for the initial fetch
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetTasksFailedState) {
            // Show an error message for the initial fetch
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            final tasks = context.read<TasksCubit>().tasks;

            return ListView.builder(
              controller: scrollController, // Attach the scroll controller
              itemCount: tasks.length +
                  1, // Add an extra item for the loading indicator
              itemBuilder: (context, index) {
                if (index == tasks.length) {
                  // Show a loading indicator when loading more tasks
                  if (context.read<TasksCubit>().isLoadingMore) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const SizedBox
                        .shrink(); // Empty widget when not loading more
                  }
                }

                // Render the task item
                return TabBarItemWidget(tasks: tasks[index]);
              },
            );
          }
        },
      ),
    );
  }
}
