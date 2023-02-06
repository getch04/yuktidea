import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/colors.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/widgets/custom_button.dart';
import 'package:yuktidea_flutter_deveoper_task/route.dart';

import '../bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: AppColors.Grey,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
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
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LogoutFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.info_outline_rounded,
                                color: AppColors.Black,
                              ),
                            ),
                            Expanded(
                                child: Text(
                              "Logout failed",
                              style: TextStyle(
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
                  if (state is LogoutSuccess) {
                    
                    Navigator.pushNamedAndRemoveUntil(
                        context, Paths.login, (route) => false);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                      size: size,
                      onpress: state is LogoutLoading
                          ? null
                          : () {
                              authBloc.add(LogoutEvent());
                            },
                      text: state is LogoutLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "Logout",
                              style: TextStyle(fontSize: 17.sp),
                            ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
