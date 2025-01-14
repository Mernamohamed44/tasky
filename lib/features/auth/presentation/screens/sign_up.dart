import 'package:dropdown_textfield/dropdown_textfield.dart';
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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt()),
      child: const SignUpBody(),
    );
  }
}

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: context.read<AuthCubit>().registerFormKey,
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
                  text: 'Sign Up',
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              24.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  controller: context.read<AuthCubit>().nameController,
                  hintText: 'Name...',
                ),
              ),
              15.verticalSpace,
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
              15.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: CustomTextFormField(
                  controller: context.read<AuthCubit>().yearController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Years of experience';
                    }
                    return null;
                  },
                  hintText: 'Years of experience...',
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: DropDownTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  dropDownIconProperty: IconProperty(
                    icon: Icons.keyboard_arrow_down,
                    size: 24,
                    color: AppColors.grey7f,
                  ),
                  textFieldDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.grey80,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.grey80,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.primary,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.red,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.red,
                      ),
                    ),
                    hintText: 'Choose experience Level',
                    hintStyle: const TextStyle(
                      color: AppColors.grey7f,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: AppConstance.appFontName,
                    ),
                    errorStyle: const TextStyle(
                      color: AppColors.red,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: AppConstance.appFontName,
                    ),
                  ),
                  controller: context.read<AuthCubit>().levelController,
                  clearOption: true,
                  clearIconProperty: IconProperty(color: Colors.green),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Level";
                    } else {
                      return null;
                    }
                  },
                  dropDownList: const [
                    DropDownValueModel(name: 'fresh', value: "value1"),
                    DropDownValueModel(name: 'junior', value: "value2"),
                    DropDownValueModel(
                      name: 'midLevel',
                      value: "value3",
                    ),
                    DropDownValueModel(name: 'senior', value: "value4"),
                  ],
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: CustomTextFormField(
                  controller: context.read<AuthCubit>().addressController,
                  hintText: 'Address...',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Your address';
                    }
                    return null;
                  },
                ),
              ),
              15.verticalSpace,
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final cubit = context.read<AuthCubit>();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: CustomTextFormField(
                      controller: cubit.passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
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
              24.verticalSpace,
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is RegisterSuccessState) {
                    MagicRouter.navigateTo(
                        page: const HomeView(), withHistory: false);
                  } else if (state is RegisterFailState) {
                    showToastificationWidget(
                      message: state.message,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoadingState) {
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
                        context.read<AuthCubit>().register();
                      },
                      color: AppColors.primary,
                      text: 'Sign Up',
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
                    text: 'Already have any account?',
                    style: const TextStyle(
                        fontFamily: AppConstance.appFontName,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey7f),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Sign in',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            MagicRouter.navigatePop();
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
