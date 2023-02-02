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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static bool isPassVisible = true;
  static bool isConfirmPassVisible = true;
  static bool isLoginLoading = false;

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomHeaderWidget(
                      title: "Create New Account",
                      subtitle: "Fill in the form to continue"),
                  Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          size: size,
                          controller: nameController,
                          labelText: "Name",
                        ),
                        CustomTextFormField(
                          size: size,
                          controller: emailController,
                          labelText: "Email",
                        ),
                        CustomTextFormField(
                          size: size,
                          controller: phoneNumberController,
                          labelText: "Phone Number",
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
                        CustomPasswordTextForm(
                            size: size,
                            controller: confirmPasswordController,
                            labelText: "Confirm Password",
                            onpress: () {
                              setState(() {
                                isConfirmPassVisible = !isConfirmPassVisible;
                              });
                            },
                            isVisible: isConfirmPassVisible),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        CustomButton(
                            size: size,
                            onpress: () {
                              Navigator.pushNamed(context, Paths.otp);
                            },
                            text: Text(
                                    " Sign Up",
                                    style: TextStyle(fontSize: 17.sp),
                                  )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an Account?',
                              style: TextStyle(
                                  color: AppColors.White.withOpacity(0.5),
                                  fontSize: 14.sp),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: AppColors.Red, fontSize: 14.sp),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
