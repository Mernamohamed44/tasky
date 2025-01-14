import 'package:flutter/material.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/utils/constance.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.isScrollable,
    this.pages,
    required this.controller,
  });

  final List<Widget> tabs;
  final List<Widget>? pages;
  final bool isScrollable;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(),
          child: TabBar(
            controller: controller,
            labelColor: AppColors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: AppConstance.appFontName),
            unselectedLabelColor: const Color(0xff7C7C80),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColors.primary,
            ),
            dividerColor: Colors.transparent,
            isScrollable: isScrollable,
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            unselectedLabelStyle: const TextStyle(
              fontFamily: AppConstance.appFontName,
              fontWeight: FontWeight.w400,
            ),
            tabAlignment: TabAlignment.start,
            tabs: tabs,
          ),
        ),
        if (pages != null)
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: pages!,
            ),
          )
      ],
    );
  }
}
