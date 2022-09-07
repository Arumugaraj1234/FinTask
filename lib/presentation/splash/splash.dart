import 'package:fin_task/app/app_prefs.dart';
import 'package:fin_task/app/di.dart';
import 'package:fin_task/presentation/resources/asset_manager.dart';
import 'package:fin_task/presentation/resources/color_manager.dart';
import 'package:fin_task/presentation/resources/routes_manager.dart';
import 'package:fin_task/presentation/resources/value_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _appPreferences = instance<AppPreferences>();

  _bind() async {
    await FirebaseMessaging.instance.requestPermission();

    bool isUserLoggedIn = await _appPreferences.isUserLoggedIn();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(DurationManager.secondTwo, () {
        if (isUserLoggedIn) {
          Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
        } else {
          Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
        }
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primary,
      child: Center(
        child: Image.asset(ImagesManager.appLogo),
      ),
    );
  }
}
