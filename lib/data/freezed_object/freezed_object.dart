import 'package:fin_task/data/realm_data/realm_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_object.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class HomeObject with _$HomeObject {
  factory HomeObject(List<Employee> employees) = _HomeObject;
}
