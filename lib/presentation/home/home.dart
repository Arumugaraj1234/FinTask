import 'package:fin_task/app/enums.dart';
import 'package:fin_task/data/realm_data/realm_data.dart';
import 'package:fin_task/presentation/home/home_viewmodel.dart';
import 'package:fin_task/presentation/resources/color_manager.dart';
import 'package:fin_task/presentation/resources/fonts_manager.dart';
import 'package:fin_task/presentation/resources/strings_manager.dart';
import 'package:fin_task/presentation/resources/value_manager.dart';
import 'package:fin_task/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var config = Configuration([Employee.schema]);
  Realm? _realm;
  final _viewModel = HomeViewModel();

  final List<String> _sortOptions = <String>[
    AppStrings.sortByName,
    AppStrings.sortByAge,
    AppStrings.sortByCity
  ];

  _bind() async {
    _viewModel.start();
    _realm = Realm(config);
    _realm?.all<Employee>().changes.listen((event) {
      //todo: Listen call back called
    });
    await Future<void>.delayed(DurationManager.milliSecondOne);
    _writeDataToRealm();
    _readDataFromRealm();
    await Future<void>.delayed(DurationManager.milliSecondOne);
  }

  _dispose() {
    _viewModel.dispose();
    _realm?.close();
  }

  _writeDataToRealm() {
    _realm?.write(() {
      for (Employee emp in DataService.employees) {
        _realm?.add(emp);
      }
    });
  }

  _readDataFromRealm() {
    RealmResults<Employee>? employees = _realm?.all<Employee>();

    List<Employee> vEmployees = [];
    List<Employee?>? emps = employees?.map((Employee? e) => e).toList();

    for (Employee? employee in emps ?? []) {
      Employee emp = employee!;
      vEmployees.add(emp);
    }
    _viewModel.setEmployeesList(vEmployees);
  }

  void _onSelectOption(String option) async {
    if (option == AppStrings.sortByName) {
      _viewModel.sort(SortType.byName);
    } else if (option == AppStrings.sortByAge) {
      _viewModel.sort(SortType.byAge);
    } else {
      _viewModel.sort(SortType.byCity);
    }
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
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(title: const Text(AppStrings.appName), actions: <Widget>[
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return _sortOptions.map((String option) {
              return PopupMenuItem(
                child: Text(
                  option,
                  style: getRegularTextStyle(),
                ),
                value: option,
              );
            }).toList();
          },
          child: const Padding(
            padding: EdgeInsets.all(AppPadding.p10),
            child: Icon(Icons.more_vert),
          ),
          onSelected: _onSelectOption,
        )
      ]),
      body: Container(
        color: ColorManager.white,
        child: StreamBuilder<List<Employee>>(
            stream: _viewModel.outputEmployees,
            builder: (context, snapshot) {
              List<Employee> employees = snapshot.data ?? [];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      Employee employee = employees[index];
                      return Card(
                        color: ColorManager.babyBlue,
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Row(
                            children: [
                              //Text((employee.id ?? 0).toString()),
                              Expanded(
                                  child: Text(
                                employee.name ?? "",
                                style: getRegularTextStyle(),
                              )),
                              const SizedBox(
                                width: AppSize.s10,
                              ),
                              Text(
                                (employee.age ?? "").toString(),
                                style: getRegularTextStyle(),
                              ),
                              const SizedBox(
                                width: AppSize.s10,
                              ),
                              Text(
                                employee.city ?? "",
                                style: getRegularTextStyle(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
