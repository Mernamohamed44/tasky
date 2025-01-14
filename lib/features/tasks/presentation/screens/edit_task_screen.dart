import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/app/dependancy_injection/dependancy_injection.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/app/network/end_points.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/constance.dart';
import 'package:tasky/app/utils/image_manager.dart';
import 'package:tasky/app/widget/custom_button.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/app/widget/custom_text_form_field.dart';
import 'package:tasky/app/widget/toastification_widget.dart';
import 'package:tasky/features/tasks/presentation/presentaion_logic_holder/tasks_cubit.dart';
import 'package:tasky/features/tasks/presentation/screens/home_screen.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.desc,
      required this.priority,
      required this.date,
      required this.user,
      required this.status,
      required this.id});

  final String image;
  final String title;
  final String desc;
  final String priority;
  final String date;
  final String user;
  final String status;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(getIt()),
      child: EditTaskBody(
        image: image,
        priority: priority,
        desc: desc,
        date: date,
        title: title,
        user: user,
        status: status,
        id: id,
      ),
    );
  }
}

class EditTaskBody extends StatefulWidget {
  const EditTaskBody(
      {super.key,
      required this.image,
      required this.title,
      required this.desc,
      required this.priority,
      required this.date,
      required this.user,
      required this.id,
      required this.status});

  final String image;
  final String title;
  final String desc;
  final String priority;
  final String date;
  final String user;
  final String id;
  final String status;

  @override
  State<EditTaskBody> createState() => _EditTaskBodyState();
}

class _EditTaskBodyState extends State<EditTaskBody> {
  @override
  void initState() {
    context.read<TasksCubit>().titleController.text = widget.title;
    context.read<TasksCubit>().descriptionController.text = widget.desc;
    context.read<TasksCubit>().startDateController.text = widget.date;
    context.read<TasksCubit>().startDateController.text = widget.date;
    context.read<TasksCubit>().taskImageUploaded = widget.image;
    context.read<TasksCubit>().priorityController.setDropDown(
        DropDownValueModel(name: widget.priority, value: widget.priority));
    context.read<TasksCubit>().statusController.setDropDown(
        DropDownValueModel(name: widget.status, value: widget.status));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                      text: 'Edit task',
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
                    onTap: () {
                      cubit.chooseImage(
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
                          child: state is UploadImageSuccessState
                              ? Image.file(File(cubit.taskImage!.path))
                              : Image.network(
                                  '${ApiConstants.baseImagesUrl}${widget.image}')),
                    ),
                  );
                },
              ),
              20.verticalSpace,
              CustomTextFormField(
                controller: context.read<TasksCubit>().titleController,
                title: 'Task title',
                hintText: widget.title,
              ),
              20.verticalSpace,
              CustomTextFormField(
                controller: context.read<TasksCubit>().descriptionController,
                title: 'Task Description',
                hintText: 'Enter description here...',
                maxLines: 6,
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
                        // hintText: widget.priority,
                        hintStyle: const TextStyle(
                            fontFamily: AppConstance.appFontName,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary)),
                    controller: cubit.priorityController,
                    clearOption: true,
                    enableSearch: false,
                    clearIconProperty: IconProperty(color: Colors.green),
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
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
                  return DropDownTextField(
                    dropDownIconProperty: IconProperty(
                        icon: Icons.keyboard_arrow_down,
                        size: 24,
                        color: AppColors.grey7f),
                    textFieldDecoration: InputDecoration(
                        prefixIcon: Image.asset(ImageManager.flagIcon),
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
                        // hintText: widget.priority,
                        hintStyle: const TextStyle(
                            fontFamily: AppConstance.appFontName,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary)),
                    controller: cubit.statusController,
                    clearOption: true,
                    enableSearch: false,
                    clearIconProperty: IconProperty(color: Colors.green),
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 3,
                    dropDownList: const [
                      DropDownValueModel(name: 'inporgress', value: "value1"),
                      DropDownValueModel(
                        name: 'waiting',
                        value: "value2",
                      ),
                      DropDownValueModel(name: 'finished', value: "value3"),
                    ],
                    onChanged: (val) {
                      if (val is DropDownValueModel) {
                        print(val.name);
                      }
                    },
                  );
                },
              ),
              30.verticalSpace,
              BlocConsumer<TasksCubit, TasksState>(
                listener: (context, state) {
                  if (state is EditTasksSuccessState) {
                    MagicRouter.navigateTo(
                        page: const HomeView(), withHistory: false);
                  } else if (state is EditTasksFailedState) {
                    showToastificationWidget(
                      message: state.message,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is EditTasksLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomButton(
                      onTap: () {
                        context.read<TasksCubit>().editTasks(
                            user: widget.user,
                            id: widget.id);
                      },
                      color: AppColors.primary,
                      text: 'Edit task',
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
    );
  }
}
