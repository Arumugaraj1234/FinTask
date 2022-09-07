import 'package:fin_task/app/enums.dart';
import 'package:fin_task/data/freezed_object/freezed_object.dart';
import 'package:fin_task/data/realm_data/realm_data.dart';
import 'package:fin_task/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final _employeesStreamController = BehaviorSubject<List<Employee>>();

  HomeObject _homeObject = HomeObject([]);

  @override
  void start() {}

  @override
  void dispose() {
    _employeesStreamController.close();
    super.dispose();
  }

  //INPUTS

  @override
  setEmployeesList(List<Employee> employees) {
    _homeObject = _homeObject.copyWith(employees: employees);
    inputEmployees.add(employees);
  }

  @override
  sort(SortType type) {
    List<Employee> employees = _homeObject.employees;
    switch (type) {
      case SortType.byName:
        employees.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
        break;
      case SortType.byAge:
        employees.sort((a, b) => (a.age ?? 0).compareTo(b.age ?? 0));
        break;
      case SortType.byCity:
        employees.sort((a, b) => (a.city ?? "").compareTo(b.city ?? ""));
        break;
    }
    inputEmployees.add(employees);
  }

  @override
  Sink<List<Employee>> get inputEmployees => _employeesStreamController.sink;

  //OUTPUTS

  @override
  Stream<List<Employee>> get outputEmployees =>
      _employeesStreamController.stream.map((employees) => employees);

  //PRIVATE FUNCTIONS

}

abstract class HomeViewModelInputs {
  setEmployeesList(List<Employee> employees);
  sort(SortType type);

  Sink<List<Employee>> get inputEmployees;
}

abstract class HomeViewModelOutputs {
  Stream<List<Employee>> get outputEmployees;
}
