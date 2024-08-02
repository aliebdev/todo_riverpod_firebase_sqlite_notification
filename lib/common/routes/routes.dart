import 'package:flutter/material.dart';
import 'package:todo/features/auth/pages/login_page.dart';
import 'package:todo/features/auth/pages/otp_page.dart';
import 'package:todo/features/onboarding/pages/on_boarding_page.dart';
import 'package:todo/features/todo/pages/home_page.dart';

class Routes {
  static const String onBoarding = "onBoarding";
  static const String login = "login";
  static const String otp = "otp";
  static const String home = "home";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => OtpPage(
            phone: args['phone'],
            smsCodeId: args['smsCodeId'],
          ),
        );
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
