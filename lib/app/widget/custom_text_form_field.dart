import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app/widget/custom_text.dart';

import '../utils/colors.dart';
import '../utils/constance.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Color? filledColor;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final bool readOnly, isLastInput;
  final int? maxLines, maxLength;
  final Color? borderColor;
  final TextStyle? textStyle;
  final AutovalidateMode? autoValidateMode;
  final double borderRadius;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.title = '',
    this.titleFontSize = 13,
    this.suffixIcon,
    this.keyboardType,
    this.prefixIcon,
    this.readOnly = false,
    this.isLastInput = false,
    this.validator,
    this.controller,
    this.hintText,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.borderColor,
    this.textStyle,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.filledColor,
    this.borderRadius = 10,
    this.initialValue,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != ''
            ? Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: CustomText(
                  text: title,
                  color: const Color(0xff6E6A7C),
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox.shrink(),
        TextFormField(
          initialValue: initialValue,
          controller: controller,
          inputFormatters: inputFormatters,
          // [FilteringTextInputFormatter.digitsOnly],
          validator: validator,
          autovalidateMode: autoValidateMode,
          onTap: onTap,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          style: textStyle ??
              const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: AppConstance.appFontName,
              ),
          readOnly: readOnly,
          textInputAction:
              isLastInput ? TextInputAction.done : TextInputAction.next,
          obscureText: obscureText,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            prefixIconConstraints:
                const BoxConstraints(minHeight: 20, minWidth: 30),
            fillColor: filledColor ?? AppColors.white,
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
            counterStyle: const TextStyle(fontSize: 0),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: BorderSide(
                width: 1,
                color: borderColor ?? AppColors.grey80,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.grey80,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.primary,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.primary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// CustomTextFormField(
// title: "اسم المستخدم",
// controller: cubit.userNameController,
// filledColor: AppColors.white,
// validator: (value) {
// if (value!.isEmpty) {
// return "ادخل اسم المستخدم !";
// }
// return null;
// },
// )
