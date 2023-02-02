import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/constants.dart';
import 'package:yuktidea_flutter_deveoper_task/core/utils/shared_preference.dart';
import 'package:yuktidea_flutter_deveoper_task/di.dart' as di;
import 'package:yuktidea_flutter_deveoper_task/di.dart';
import 'package:yuktidea_flutter_deveoper_task/route.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => sl<AuthBloc>(),
      ),
    ], child: const AuthApp());
  }
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d(Storage.getString(AppConstants.tokenkey));
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            color: Colors.white,
            title: 'Auth App',
            navigatorKey: AppNavigator.navigatorKey,
            initialRoute: Storage.getString(AppConstants.tokenkey) == ""
                ? Paths.splash
                : Paths.home,
            theme: ThemeData(
                // fontFamily: GoogleFonts.montserrat(
                // ),

                ),
            onGenerateRoute: AppNavigator.onGenerateRoute,
            builder: (context, child) {
              if (child == null) return const SizedBox.shrink();
              final data = MediaQuery.of(context);
              final smallestSize = min(data.size.width, data.size.height);
              final textScaleFactor =
                  min(smallestSize / AppConstants.designScreenSize.width, 1.0);
              return MediaQuery(
                data: data.copyWith(textScaleFactor: textScaleFactor),
                child: child,
              );
            },
          );
        });
  }
}
