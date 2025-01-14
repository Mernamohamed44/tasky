import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/app/dependancy_injection/dependancy_injection.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/constance.dart';
import 'package:tasky/app/utils/image_manager.dart';
import 'package:tasky/app/widget/custom_button.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/app/widget/custom_text_form_field.dart';
import 'package:tasky/app/widget/phone_number_input.dart';
import 'package:tasky/app/widget/toastification_widget.dart';
import 'package:tasky/features/tasks/presentation/screens/home_screen.dart';

import '../presentation_logic_holder/auth_cubit.dart';
import 'sign_up.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: const LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: context.read<AuthCubit>().loginFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                ImageManager.onboarding,
                height: .5.sh,
                width: 1.sw,
                fit: BoxFit.cover,
              ),
              15.verticalSpace,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: 'Login',
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              25.verticalSpace,
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final cubit = context.read<AuthCubit>();
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: PhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        cubit.onInputChanged(number);
                      },
                    ),
                  );
                },
              ),
              20.verticalSpace,
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final cubit = context.read<AuthCubit>();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: CustomTextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      controller: cubit.passwordController,
                      hintText: 'Password...',
                      suffixIcon: SizedBox(
                        height: 0.02.sh,
                        child: GestureDetector(
                          onTap: () {
                            cubit.changeVisibility();
                          },
                          child: Icon(
                            cubit.isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.grey80,
                          ),
                        ),
                      ),
                      obscureText: cubit.isObscure,
                    ),
                  );
                },
              ),
              25.verticalSpace,
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LogInSuccessState) {
                    MagicRouter.navigateTo(
                        page: const HomeView(), withHistory: false);
                  } else if (state is LogInFailState) {
                    showToastificationWidget(
                      message: state.message,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<AuthCubit>();
                  if (state is LogInLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: CustomButton(
                      onTap: () {
                        cubit.login();
                      },
                      color: AppColors.primary,
                      text: 'Sign In',
                      fontSize: 16,
                      fontColor: AppColors.white,
                    ),
                  );
                },
              ),
              24.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 58),
                child: RichText(
                  text: TextSpan(
                    text: 'Didn’t have any account? ',
                    style: const TextStyle(
                        fontFamily: AppConstance.appFontName,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey7f),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign Up here',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            MagicRouter.navigateTo(
                              page: const SignUpScreen(),
                            );
                          },
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: AppConstance.appFontName,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
