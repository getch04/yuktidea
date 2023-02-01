import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.Grey,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.15),
          child: Column(
            children: [
              Icon(
                Icons.camera,
                color: AppColors.White,
                size: 90.h,
              ),
              Text(
                "CINE COMPASS".toUpperCase(),
                style: TextStyle(color: AppColors.White, fontSize: 26.sp),
              ),
              Text(
                "Home".toUpperCase(),
                style: TextStyle(color: AppColors.White, fontSize: 26.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
