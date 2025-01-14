import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/constance.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.withLeading = true,
    this.withActions = true,
    this.fontFamily = AppConstance.appFontName,
    this.fontSize,
  });

  final String text;
  final bool withLeading;
  final bool withActions;
  final String? fontFamily;
  final double? fontSize;

  @override
  Size get preferredSize => Size.fromHeight(50.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: withLeading
          ? IconButton(
              onPressed: () {},
              color: AppColors.black,
              icon: const Icon(Icons.arrow_back_sharp),
            )
          : const SizedBox(
              width: 10,
            ),
      title: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: fontSize ?? 20,
            fontFamily: fontFamily ?? 'cairo',
          ),
        ),
      ),
      centerTitle: false,
    );
  }
}
