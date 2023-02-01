import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_button.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_header_widget.dart';
import 'package:yuktidea_flutter_deveoper_task/route.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.Grey,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomHeaderWidget(
                    title: "Verify Phone Number",
                    subtitle: "Enter the OTP received on your number"),
                Column(
                  children: [
                    SizedBox(
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        backgroundColor: AppColors.Grey,
                        animationDuration: const Duration(milliseconds: 500),
                        animationType: AnimationType.scale,
                        blinkWhenObscuring: true,
                        boxShadows: [
                          BoxShadow(
                            color: AppColors.Black,
                            offset: const Offset(
                              1,
                              1,
                            ),
                            blurRadius: 1,
                            spreadRadius: 0.8,
                          ),
                        ],
                        textStyle: TextStyle(color: AppColors.White),
                        hintCharacter: '0',
                        hintStyle:
                            TextStyle(color: AppColors.White.withOpacity(0.4)),
                        onChanged: (value) {},
                        cursorColor: Colors.grey.shade300,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          // activeColor: blue,
                          // selectedColor: blue,
                          selectedFillColor: AppColors.Black,

                          inactiveFillColor: AppColors.Black,

                          inactiveColor: AppColors.Black,
                          activeFillColor: AppColors.Red.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          // fieldHeight: 50,
                          fieldWidth: 50,
                          borderWidth: 3,
                          shape: PinCodeFieldShape.box,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Resend OTP in',
                          style: TextStyle(
                              color: AppColors.White.withOpacity(0.5),
                              fontSize: 14.sp),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Paths.home);
                            },
                            child: Text(
                              '10 seconds',
                              style: TextStyle(
                                  color: AppColors.Red, fontSize: 14.sp),
                            ))
                      ],
                    ),
                  ],
                ),
                CustomButton(
                    size: size,
                    onpress: () {
                      Navigator.pushNamed(context, Paths.home);
                    },
                    text: "Verify"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
