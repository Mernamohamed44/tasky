import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/app/dependancy_injection/dependancy_injection.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/constance.dart';
import 'package:tasky/app/utils/image_manager.dart';
import 'package:tasky/app/widget/custom_button.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/app/widget/custom_text_form_field.dart';
import 'package:tasky/app/widget/toastification_widget.dart';
import 'package:tasky/features/tasks/presentation/presentaion_logic_holder/tasks_cubit.dart';
import 'package:tasky/features/tasks/presentation/screens/home_screen.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(getIt()),
      child: AddTaskBody(),
    );
  }
}

class AddTaskBody extends StatefulWidget {
  const AddTaskBody({super.key});

  @override
  State<AddTaskBody> createState() => _AddTaskBodyState();
}

class _AddTaskBodyState extends State<AddTaskBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: context.read<TasksCubit>().addTaskFormKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
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
                        text: 'Add new task',
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                36.verticalSpace,
                BlocBuilder<TasksCubit, TasksState>(
                  builder: (context, state) {
                    final cubit = context.read<TasksCubit>();

                    return GestureDetector(
                      onTap: () async {
                          await cubit.chooseImage(
                              source: ImageSource.gallery, context: context);
                      },
                      child: DottedBorder(
                        color: AppColors.primary,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: cubit.taskImage == null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Image.asset(ImageManager.addImage),
                                      5.horizontalSpace,
                                      const CustomText(
                                        text: 'Add Img',
                                        color: AppColors.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ])
                              : Image.file(File(cubit.taskImage!.path)),
                        ),
                      ),
                    );
                  },
                ),
                20.verticalSpace,
                CustomTextFormField(
                  controller: context.read<TasksCubit>().titleController,
                  title: 'Task title',
                  hintText: 'Enter title here...',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Please Enter title';
                    } else {
                      return null;
                    }
                  },
                ),
                20.verticalSpace,
                CustomTextFormField(
                  controller: context.read<TasksCubit>().descriptionController,
                  title: 'Task Description',
                  hintText: 'Enter description here...',
                  maxLines: 6,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Please Enter Description';
                    } else {
                      return null;
                    }
                  },
                ),
                20.verticalSpace,
                BlocBuilder<TasksCubit, TasksState>(
                  builder: (context, state) {
                    final cubit = context.read<TasksCubit>();
                    return DropDownTextField(
                      dropDownIconProperty: IconProperty(
                          icon: Icons.keyboard_arrow_down,
                          size: 24,
                          color: AppColors.grey7f),
                      textFieldDecoration: InputDecoration(
                          prefixIcon: Image.asset(ImageManager.flagIcon),
                        errorStyle: const TextStyle(
                          color: AppColors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontFamily: AppConstance.appFontName,
                        ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.palePrimary,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.palePrimary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.palePrimary,
                            ),
                          ),
                          fillColor: AppColors.palePrimary,
                          filled: true,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.palePrimary,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.palePrimary,
                            ),
                          ),
                          hintText: 'Medium Priority',
                          hintStyle: const TextStyle(
                              fontFamily: AppConstance.appFontName,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary)),
                      controller: cubit.priorityController,
                      clearOption: true,
                      enableSearch: false,

                      clearIconProperty: IconProperty(color: Colors.green),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Priority";
                        } else {
                          return null;
                        }
                      },

                      dropDownItemCount: 3,
                      dropDownList: const [
                        DropDownValueModel(name: 'medium', value: "value1"),
                        DropDownValueModel(
                          name: 'low',
                          value: "value2",
                        ),
                        DropDownValueModel(name: 'high', value: "value3"),
                      ],
                      onChanged: (val) {
                        if (val is DropDownValueModel) {
                          print(val.name);
                        }
                      },
                    );
                  },
                ),
                20.verticalSpace,
                BlocBuilder<TasksCubit, TasksState>(
                  builder: (context, state) {
                    final cubit = context.read<TasksCubit>();
                    return CustomTextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Please Enter Date';
                        } else {
                          return null;
                        }
                      },
                      controller: cubit.startDateController,
                      title: 'Due date',
                      hintText: 'choose due date...',
                      readOnly: true,
                      onTap: () {
                        cubit.pressDate(context);
                      },
                      suffixIcon: const Icon(Icons.date_range_outlined),
                    );
                  },
                ),
                30.verticalSpace,
                BlocConsumer<TasksCubit, TasksState>(
                  listener: (context, state) {
                    if (state is AddTasksSuccessState) {
                      MagicRouter.navigateTo(
                          page: HomeView(), withHistory: false);
                    } else if (state is AddTasksFailedState) {
                      showToastificationWidget(
                        message: state.message,
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddTasksLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: CustomButton(
                        onTap: () {
                          context.read<TasksCubit>().addTasks(context);
                        },
                        color: AppColors.primary,
                        text: 'Add task',
                        fontSize: 19,
                        fontColor: AppColors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
