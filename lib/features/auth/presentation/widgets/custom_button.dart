import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.size,
    required this.onpress,
    required this.text,
  });

  final Size size;
  final String text;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.6,
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.Red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
    );
  }
}
