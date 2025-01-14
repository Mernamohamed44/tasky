import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app/dependancy_injection/dependancy_injection.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/image_manager.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/features/auth/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:tasky/features/auth/presentation/widgets/profile_container_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt()),
      child: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().getUserData();
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is UserDataLoadingState) {
            return Center(
              child: const CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (state is UserDataFailState) {
            return Center(
                child: CustomText(text: state.message, color: AppColors.red));
          }
          var user = context.read<AuthCubit>().user;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
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
                          text: 'Profile',
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  ProfileContainerWidget(
                    head: 'Name',
                    text: user!.displayName!,
                  ),
                  10.verticalSpace,
                  ProfileContainerWidget(
                    head: 'Phone',
                    text: user.username!,
                  ),
                  10.verticalSpace,
                  ProfileContainerWidget(
                    head: 'Level',
                    text: user.level!,
                  ),
                  10.verticalSpace,
                  ProfileContainerWidget(
                    head: 'ExperienceYears',
                    text: '${user.experienceYears!}',
                  ),
                  10.verticalSpace,
                  ProfileContainerWidget(
                    head: 'Address',
                    text: user.address!,
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
