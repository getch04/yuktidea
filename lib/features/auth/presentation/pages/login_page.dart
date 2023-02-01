import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static bool isPassVisible = true;
  static bool isLoginLoading = false;

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.Grey,
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.1, horizontal: size.width * 0.1),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            height: size.height * 0.85,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    child: Column(
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(color: AppColors.White, fontSize: 26.sp),
                    ),
                    Text(
                      "Please sign in to your account",
                      style: TextStyle(color: AppColors.White, fontSize: 14.sp),
                    ),
                  ],
                )),
                SizedBox(
                  height: size.height * 0.5,
                  width: size.width,
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15.w),
                          margin: EdgeInsets.only(bottom: size.height * 0.02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.Black,
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            controller: usernameController,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                labelText: "Username",
                                enabledBorder: InputBorder.none,
                                labelStyle: GoogleFonts.montserrat(
                                  color: AppColors.White.withOpacity(0.5),
                                )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.Black,
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            obscureText: isPassVisible ? true : false,
                            controller: passwordController,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: "Password",
                              enabledBorder: InputBorder.none,
                              labelStyle: GoogleFonts.montserrat(
                                color: AppColors.White.withOpacity(0.5),
                              ),
                              suffixIcon: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isPassVisible = !isPassVisible;
                                  });
                                },
                                child: Icon(
                                  isPassVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.White.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password?',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                              color: AppColors.White.withOpacity(0.5),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    child: Column(
                  children: [
                    CustomButton(size: size, onpress: () {}, text: "Login"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                              color: AppColors.White.withOpacity(0.5),
                              fontSize: 14.sp),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                  color: AppColors.Red, fontSize: 14.sp),
                            ))
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
