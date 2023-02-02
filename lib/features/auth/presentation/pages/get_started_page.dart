import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/images.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_button.dart';
import 'package:yuktidea_flutter_deveoper_task/route.dart';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height.h,
        width: size.width.w,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AppImages.bg_image, fit: BoxFit.fill),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.07, horizontal: size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: size.height * 0.1,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.camera,
                      color: AppColors.White,
                      size: 40.sp,
                    ),
                    Text('cINE cOMPASS'.toUpperCase(),
                        style: GoogleFonts.roboto(
                            color: AppColors.White, fontSize: 30.sp))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.14,
                child: Column(
                  children: [
                    Text(
                      'Your one step solution to'.toUpperCase(),
                      style: TextStyle(color: AppColors.White, fontSize: 14.sp),
                    ),
                    Text(
                      "Rent Pre-production Equipments Easly",
                      style: TextStyle(color: AppColors.White, fontSize: 14.sp),
                    ),
                    Flex(direction: Axis.vertical),
                    Expanded(
                      child: SizedBox(
                        height: size.height * 0.02,
                      ),
                    ),
                    CustomButton(
                        size: size,
                        text: Text(
                          "Get Started",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        onpress: () {
                          Navigator.pushNamed(context, Paths.login);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
