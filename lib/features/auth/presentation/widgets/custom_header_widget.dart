import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    super.key,
    required this.subtitle,
    required this.title,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      children: [
        Text(
          title,
          style: TextStyle(color: AppColors.White, fontSize: 26.sp),
        ),
        Text(
          subtitle,
          style: TextStyle(color: AppColors.White, fontSize: 14.sp),
        ),
      ],
    ));
  }
}
