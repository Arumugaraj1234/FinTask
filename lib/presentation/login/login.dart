import 'package:fin_task/app/di.dart';
import 'package:fin_task/presentation/login/login_viewmodel.dart';
import 'package:fin_task/presentation/resources/asset_manager.dart';
import 'package:fin_task/presentation/resources/color_manager.dart';
import 'package:fin_task/presentation/resources/routes_manager.dart';
import 'package:fin_task/presentation/resources/strings_manager.dart';
import 'package:fin_task/presentation/resources/value_manager.dart';
import 'package:fin_task/presentation/state_renderer/state_renderer_implementer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _userNameTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _viewModel = instance<LoginViewModel>();

  _bind() async {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });
    _viewModel.loginSuccessStreamController.listen((_) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
      });
    });
    String firebaseToken = await FirebaseMessaging.instance.getToken() ?? "";
    print(firebaseToken);
  }

  _dispose() {
    _viewModel.dispose();
    _userNameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorManager.primary,
          body: _content(context),
        ),
        StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getWidget(context, (action) {
                    _viewModel.hideState();
                  }) ??
                  Container();
            })
      ],
    );
  }

  _content(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    return Listener(
      child: SafeArea(
        child: Container(
          color: ColorManager.white,
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImagesManager.appLogo),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        StreamBuilder<String?>(
                            stream: _viewModel.outputUserNameError,
                            builder: (context, snapshot) {
                              return TextFormField(
                                controller: _userNameTextEditingController,
                                focusNode: _userNameFocusNode,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                                decoration: InputDecoration(
                                    labelText: AppStrings.userName,
                                    hintText: AppStrings.userName,
                                    errorText: snapshot.data),
                              );
                            }),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        StreamBuilder<String?>(
                            stream: _viewModel.outputPasswordError,
                            builder: (context, snapshot) {
                              return TextFormField(
                                controller: _passwordTextEditingController,
                                focusNode: _passwordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                decoration: InputDecoration(
                                    labelText: AppStrings.password,
                                    hintText: AppStrings.password,
                                    errorText: snapshot.data),
                              );
                            }),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        StreamBuilder<bool>(
                            stream: _viewModel.outputIsValidToLogin,
                            builder: (context, snapshot) {
                              return SizedBox(
                                height: AppSize.s50,
                                width: AppSize.s150,
                                child: ElevatedButton(
                                    onPressed: (snapshot.data ?? false)
                                        ? () {
                                            _viewModel.login();
                                          }
                                        : null,
                                    child: const Text(AppStrings.login)),
                              );
                            }),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
      onPointerDown: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
