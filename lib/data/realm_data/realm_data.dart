import 'package:realm/realm.dart';
part 'realm_data.g.dart';

@RealmModel()
class _Employee {
  int? id;
  String? name;
  int? age;
  String? city;
}
