// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_data.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Employee extends _Employee with RealmEntity, RealmObject {
  Employee({
    int? id,
    String? name,
    int? age,
    String? city,
  }) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'age', age);
    RealmObject.set(this, 'city', city);
  }

  Employee._();

  @override
  int? get id => RealmObject.get<int>(this, 'id') as int?;
  @override
  set id(int? value) => RealmObject.set(this, 'id', value);

  @override
  String? get name => RealmObject.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObject.set(this, 'name', value);

  @override
  int? get age => RealmObject.get<int>(this, 'age') as int?;
  @override
  set age(int? value) => RealmObject.set(this, 'age', value);

  @override
  String? get city => RealmObject.get<String>(this, 'city') as String?;
  @override
  set city(String? value) => RealmObject.set(this, 'city', value);

  @override
  Stream<RealmObjectChanges<Employee>> get changes =>
      RealmObject.getChanges<Employee>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Employee._);
    return const SchemaObject(Employee, [
      SchemaProperty('id', RealmPropertyType.int, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('age', RealmPropertyType.int, optional: true),
      SchemaProperty('city', RealmPropertyType.string, optional: true),
    ]);
  }
}
