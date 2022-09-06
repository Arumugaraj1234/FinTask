import 'package:fin_task/presentation/resources/color_manager.dart';
import 'package:fin_task/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Container(
        color: ColorManager.white,
      ),
    );
  }
}
