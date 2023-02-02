import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/domain/models/register_model.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_button.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_header_widget.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_input_field.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_password_text_form_widget.dart';
import 'package:yuktidea_flutter_deveoper_task/route.dart';

import '../bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static bool isPassVisible = true;
  static bool isConfirmPassVisible = true;
  static bool isLoginLoading = false;

  final registerFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.Black,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    state.msg,
                    style: const TextStyle(
                      color: AppColors.White,
                    ),
                  )),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.Red,
              duration: const Duration(seconds: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }
        if (state is RegisterSuccess) {
          Navigator.pushNamed(context, Paths.otp);
          authBloc.add(OtpEvent());
        }
      },
      child: Scaffold(
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
                    const CustomHeaderWidget(
                        title: "Create New Account",
                        subtitle: "Fill in the form to continue"),
                    Form(
                      key: registerFormKey,
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
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return CustomButton(
                                  size: size,
                                  onpress: state is RegisterLoading
                                      ? null
                                      : () {
                                          if (registerFormKey.currentState!
                                              .validate()) {
                                            authBloc.add(
                                              RegisterEvent(
                                                RegisterModel(
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    phone: phoneNumberController
                                                        .text,
                                                    password:
                                                        passwordController.text,
                                                    passwordConfirmation:
                                                        confirmPasswordController
                                                            .text),
                                              ),
                                            );
                                          } else {
                                            autovalidateMode = AutovalidateMode
                                                .onUserInteraction;
                                          }
                                        },
                                  text: state is RegisterLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          " Sign Up",
                                          style: TextStyle(fontSize: 17.sp),
                                        ));
                            },
                          ),
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
                                onPressed: () {
                                  Navigator.pushNamed(context, Paths.login);
                                },
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
      ),
    );
  }
}
