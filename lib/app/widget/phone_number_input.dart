import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/constance.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({
    Key? key,
    required this.onInputChanged,
    this.validator,
    this.isLastInput = false,
    this.readOnly = false,
    this.hint = "123 456-7890",
    this.isoCode = "EG",
    this.autoValidate = AutovalidateMode.onUserInteraction,
    this.onTap,
  }) : super(key: key);
  final Function(PhoneNumber)? onInputChanged;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final bool isLastInput, readOnly;
  final String hint;
  final String? isoCode;
  final AutovalidateMode autoValidate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      readOnly: readOnly,
      onTap: onTap,
      initialCountryCode: isoCode,
      onChanged: onInputChanged,
      validator: validator ??
          (value) {
            if (value!.number.isEmpty) {
              return "Enter Phone";
            }
            return null;
          },
      invalidNumberMessage: "Enter Correct phone",
      autovalidateMode: autoValidate,
      dropdownIconPosition: IconPosition.trailing,
      style: const TextStyle(
        color: AppColors.grey80,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: AppConstance.appFontName,
      ),
      textInputAction:
          isLastInput ? TextInputAction.done : TextInputAction.next,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      dropdownIcon: const Icon(
        Icons.keyboard_arrow_down,
        color: Color(0xff7F7F7F),
        size: 30,
      ),
      flagsButtonPadding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          counterStyle: const TextStyle(fontSize: 0),
          enabled: true,
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
              color: AppColors.primary,
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: AppColors.grey80,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: AppConstance.appFontName,
          )),
    );
  }
}
