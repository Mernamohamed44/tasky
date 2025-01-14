import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/widget/custom_text.dart';

class ProfileContainerWidget extends StatelessWidget {
  const ProfileContainerWidget({
    super.key,
    required this.head,
    required this.text,
    this.icon = const SizedBox(),
  });

  final String head, text;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
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
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
              icon,
            ],
          ),
        ),
      ],
    );
  }
}
