import 'package:flutter/material.dart';
import 'package:yuktidea_flutter_deveoper_task/core/widgets/fade_transition.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/pages/get_started_page.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/pages/home_page.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/pages/login_page.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/pages/otp_verify_page.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/pages/register_page.dart';

enum Routes {
  splash,
  home,
  login,
  register,
  otp
  // checkout
}

class Paths {
  // static const String splash = '/';
  static const String home = '/home';
  static const String splash = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String otp = '/otp';
  // static const String chechout = '/chechout';

  static const Map<Routes, String> _pathMap = {
    // Routes.splash: Paths.splash,
    Routes.home: Paths.home,
    Routes.splash: Paths.splash,
    Routes.register: Paths.register,
    Routes.login: Paths.login,
    Routes.otp: Paths.otp,
    // Routes.checkout: Paths.chechout,
  };

  // static String of(Routes route) => _pathMap[route] ?? splash;
  static String of(Routes route) => _pathMap[route] ?? login;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Paths.splash:
        return FadeRoute(page: GetStartedPage());
      case Paths.login:
        return FadeRoute(page: const LoginPage());
      case Paths.home:
        return FadeRoute(page: const HomePage());
      case Paths.otp:
        return FadeRoute(page: const OtpVerifyPage());
      case Paths.register:
        // final arg = settings.arguments as Product;
        return FadeRoute(page: const RegisterPage());
    }
    return FadeRoute(page: const LoginPage());
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
