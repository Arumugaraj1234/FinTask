import 'package:fin_task/app/app_prefs.dart';
import 'package:fin_task/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
}

initLoginModule() {
  bool isRegistered = instance.isRegistered<LoginViewModel>();
  if (!isRegistered) {
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
