import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_button.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_header_widget.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_input_field.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_password_text_form_widget.dart';
import 'package:yuktidea_flutter_deveoper_task/route.dart';

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
                CustomHeaderWidget(
                    title: "Welcome Back",
                    subtitle: "Please sign in to your account"),
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
                        CustomTextFormField(
                          size: size,
                          controller: usernameController,
                          labelText: "username",
                        ),
                        CustomPasswordTextForm(
                            size: size,
                            controller: passwordController,
                            labelText: "Password",
                            onpress: () {
                              setState(() {
                                isPassVisible = !isPassVisible;
                              });
                            },
                            isVisible: isPassVisible),
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
                            onPressed: () {
                              Navigator.pushNamed(context, Paths.register);
                            },
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
