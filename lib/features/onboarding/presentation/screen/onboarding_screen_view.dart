import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/image_manager.dart';
import 'package:tasky/app/widget/custom_button.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/features/auth/presentation/screens/login_view.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(ImageManager.onboarding),
              8.verticalSpace,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: 'Task Management & To-Do List',
                  color: AppColors.black,
                  fontSize: 24,
                  maxLines: 3,
                  fontWeight: FontWeight.w700,
                ),
              ),
              16.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.w),
                child: const CustomText(
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  text:
                      'This productive tool is designed to help you better manage your task project-wise conveniently!',
                  color: AppColors.accentpurple,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 32.h),
                child: CustomButton(
                  onTap: () {
                    MagicRouter.navigateTo(page: const LoginView());
                  },
                  color: AppColors.primary,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: 'Let’s Start',
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                      8.horizontalSpace,
                      Image.asset(ImageManager.arrowLeft)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
