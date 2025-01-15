import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/widget/custom_tab_bar.dart';
import 'package:tasky/features/tasks/presentation/presentaion_logic_holder/tasks_cubit.dart';

class TasksTabBar extends StatefulWidget {
  TasksTabBar({super.key});

  @override
  State<TasksTabBar> createState() => _TasksTabBarState();
}

class _TasksTabBarState extends State<TasksTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  List<String> tabs = ['All', 'In Progress', 'Waiting', 'Finished'];
  List<String> status = ['All', 'inProgress', 'waiting', 'finished'];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: CustomTabBar(
        tabs: List.generate(4, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _tabController!.index = index;
              });

              context
                  .read<TasksCubit>()
                  .refreshTasks(status: index == 0 ? '' : status[index]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: _tabController!.index == index
                    ? AppColors.primary
                    : AppColors.palePrimary,
              ),
              child: Text(tabs[index]),
            ),
          );
        }),
        isScrollable: true,
        controller: _tabController!,
      ),
    );
  }
}
