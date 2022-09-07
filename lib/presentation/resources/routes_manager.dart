import 'package:fin_task/app/di.dart';
import 'package:fin_task/presentation/home/home.dart';
import 'package:fin_task/presentation/login/login.dart';
import 'package:fin_task/presentation/resources/strings_manager.dart';
import 'package:fin_task/presentation/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/loginRoute";
  static const String homeRoute = "/homeRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    Widget noFoundPage = Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pageNotFound),
      ),
      body: const Center(
        child: Text(AppStrings.pageNotFound),
      ),
    );
    return MaterialPageRoute(builder: (_) => noFoundPage);
  }
}
