import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../utils/colors.dart';
import 'custom_text.dart';

void showToastificationWidget({
  required String message,
  required BuildContext context,
  ToastificationType notificationType = ToastificationType.error,
  int duration = 3,
}) {
  toastification.show(
    context: context,
    title: CustomText(
      text: message,
      color: AppColors.defaultTextColor,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      maxLines: 3,
    ),
    type: notificationType,
    style: ToastificationStyle.flat,
    alignment: Alignment.bottomCenter,
    direction: TextDirection.rtl,
    autoCloseDuration: Duration(seconds: duration),
  );
}
