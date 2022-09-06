import 'package:fin_task/presentation/resources/asset_manager.dart';
import 'package:fin_task/presentation/resources/color_manager.dart';
import 'package:fin_task/presentation/resources/routes_manager.dart';
import 'package:fin_task/presentation/resources/value_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  _bind() async {
    await FirebaseMessaging.instance.requestPermission();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(DurationManager.secondTwo, () {
        Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
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
