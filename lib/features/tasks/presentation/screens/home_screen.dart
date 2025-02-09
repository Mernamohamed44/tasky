import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app/caching/shared_prefs.dart';
import 'package:tasky/app/dependancy_injection/dependancy_injection.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/image_manager.dart';
import 'package:tasky/app/widget/custom_alert.dart';
import 'package:tasky/app/widget/custom_tab_bar.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/app/widget/svg_icons.dart';
import 'package:tasky/features/auth/presentation/screens/login_view.dart';
import 'package:tasky/features/auth/presentation/screens/profile_screen.dart';
import 'package:tasky/features/onboarding/presentation/screen/onboarding_screen_view.dart';
import 'package:tasky/features/tasks/presentation/presentaion_logic_holder/tasks_cubit.dart';
import 'package:tasky/features/tasks/presentation/screens/add_task_screen.dart';
import 'package:tasky/features/tasks/presentation/widgets/tasks_tab_bar.dart';

import '../widgets/qr_scanner.dart';
import '../widgets/tabbar_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(getIt())..getTasks(),
      child: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 22, left: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CustomText(
                  text: 'Logo',
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    MagicRouter.navigateTo(page: const ProfileScreen());
                  },
                  icon: const SvgIcon(
                    icon: ImageManager.personIcon,
                    color: Colors.black,
                    height: 24,
                  ),
                ),
                25.horizontalSpace,
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return BlocProvider.value(
                            value: context.read<TasksCubit>(),
                            child: CustomAlert(
                                title: 'LogOut',
                                body: 'Do You want to logout?',
                                submitWidget: TextButton(
                                  onPressed: () {
                                    Caching.clearAllData();
                                    MagicRouter.navigateTo(
                                        page: const LoginView(),
                                        withHistory: false);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: const CustomText(
                                      text: "Logout",
                                      color: AppColors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )),
                          );
                        });
                  },
                  icon: const SvgIcon(
                    icon: ImageManager.logout,
                    color: AppColors.primary,
                    height: 24,
                  ),
                )
              ],
            ),
            20.verticalSpace,
            CustomText(
              text: 'My Tasks',
              color: AppColors.grey24252C.withOpacity(.6),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            10.verticalSpace,
            TasksTabBar(),
            Expanded(
              child: TabBarBodyWidget(),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'h1',
            shape: const CircleBorder(),
            onPressed: () {
              MagicRouter.navigateTo(page: QrCodeScanner());
            },
            backgroundColor: AppColors.palePrimary,
            child: const Icon(
              Icons.qr_code_outlined,
              color: AppColors.primary,
            ),
          ),
          10.verticalSpace,
          FloatingActionButton(
            heroTag: 'h2',
            shape: const CircleBorder(),
            onPressed: () {
              MagicRouter.navigateTo(page: const AddTaskScreen());
            },
            backgroundColor: AppColors.primary,
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
