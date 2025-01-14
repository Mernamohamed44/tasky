import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/widget/custom_text.dart';

class DetailsContainerWidget extends StatelessWidget {
  const DetailsContainerWidget({
    super.key,
    this.head = '',
    required this.text,
    required this.icon,
    this.image,
  });

  final String head, text;
  final IconData icon;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.palePrimary,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (image != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        image!,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      head != ''
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: CustomText(
                                text: head,
                                color: const Color(0xff6E6A7C),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : const SizedBox.shrink(),
                      CustomText(
                        text: text,
                        color: head == '' ? AppColors.primary : AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
              Icon(icon, color: AppColors.primary, size: 26),
            ],
          ),
        ),
      ],
    );
  }
}
