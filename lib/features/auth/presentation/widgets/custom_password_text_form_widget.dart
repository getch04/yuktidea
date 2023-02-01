import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';

Container CustomPasswordTextForm(
    {required Size size,
    required bool isVisible,
    required TextEditingController controller,
    required String labelText,
    required Null Function() onpress}) {
  return Container(
    padding: EdgeInsets.only(left: 15.w),
    margin: EdgeInsets.only(bottom: size.height * 0.02),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: AppColors.Black,
    ),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'required';
        }
        return null;
      },
      style: TextStyle(color: AppColors.White.withOpacity(0.5)),
      obscureText: isVisible ? true : false,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        labelText: labelText,
        enabledBorder: InputBorder.none,
        labelStyle: GoogleFonts.montserrat(
          color: AppColors.White.withOpacity(0.5),
        ),
        suffixIcon: TextButton(
          onPressed: onpress,
          child: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.White.withOpacity(0.5),
          ),
        ),
      ),
    ),
  );
}
