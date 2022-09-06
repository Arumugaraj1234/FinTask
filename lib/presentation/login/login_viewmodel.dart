import 'package:fin_task/app/constants.dart';
import 'package:fin_task/app/extentions.dart';
import 'package:fin_task/data/freezed_data/freezed_data.dart';
import 'package:fin_task/presentation/base/base_viewmodel.dart';
import 'package:fin_task/presentation/resources/strings_manager.dart';
import 'package:fin_task/presentation/resources/value_manager.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final _userNameStreamController = BehaviorSubject<String>();
  final _passwordStreamController = BehaviorSubject<String>();
  final _isValidToLoginStreamController = BehaviorSubject<void>();
  final loginSuccessStreamController = BehaviorSubject<void>();

  LoginObject _loginObject = LoginObject("", "");

  @override
  void start() {}

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isValidToLoginStreamController.close();
    loginSuccessStreamController.close();
    super.dispose();
  }

  @override
  void login() {
    String userName = _loginObject.userName;
    String password = _loginObject.password;
    if (userName == AppConstants.validUserName &&
        password == AppConstants.validPassword) {
      popUpLoadingState();
      Future.delayed(DurationManager.secondFive, () {
        hideState();
        loginSuccessStreamController.add(null);
      });
    } else {
      popUpErrorState(AppStrings.invalidCredentialError);
    }
  }

  //INPUT

  @override
  void setUserName(String userName) {
    _loginObject = _loginObject.copyWith(userName: userName);
    inputUserName.add(userName);
    _validate();
  }

  @override
  void setPassword(String password) {
    _loginObject = _loginObject.copyWith(password: password);
    inputPassword.add(password);
    _validate();
  }

  @override
  Sink<String> get inputUserName => _userNameStreamController.sink;

  @override
  Sink<String> get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputIsValidToLogin => _isValidToLoginStreamController.sink;

  //OUTPUTS

  @override
  Stream<String?> get outputUserNameError => _userNameStreamController.stream
      .map((userName) => _userNameError(userName));

  @override
  Stream<String?> get outputPasswordError => _passwordStreamController.stream
      .map((password) => _passwordError(password));

  @override
  Stream<bool> get outputIsValidToLogin =>
      _isValidToLoginStreamController.stream.map((_) => _isValidToLogin());

  // PRIVATE FUNCTIONS

  String? _userNameError(String userName) {
    return userName.validateUserName() ? null : AppStrings.userNameError;
  }

  String? _passwordError(String password) {
    return password.validatePassword() ? null : AppStrings.passwordError;
  }

  void _validate() {
    inputIsValidToLogin.add(null);
  }

  bool _isValidToLogin() {
    return _loginObject.userName.validateUserName() &&
        _loginObject.password.validatePassword();
  }
}

abstract class LoginViewModelInputs {
  void setUserName(String userName);
  void setPassword(String password);
  void login();

  Sink<String> get inputUserName;
  Sink<String> get inputPassword;
  Sink get inputIsValidToLogin;
}

abstract class LoginViewModelOutputs {
  Stream<String?> get outputUserNameError;
  Stream<String?> get outputPasswordError;
  Stream<bool> get outputIsValidToLogin;
}
