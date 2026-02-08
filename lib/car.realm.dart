// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class CarA extends _CarA with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  CarA(
    String make,
    String model, {
    double? price = 100000,
    int? kilometers = 500,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<CarA>({
        'price': 100000,
        'kilometers': 500,
      });
    }
    RealmObjectBase.set(this, 'make', make);
    RealmObjectBase.set(this, 'model', model);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'kilometers', kilometers);
  }

  CarA._();

  @override
  String get make => RealmObjectBase.get<String>(this, 'make') as String;
  @override
  set make(String value) => RealmObjectBase.set(this, 'make', value);

  @override
  String get model => RealmObjectBase.get<String>(this, 'model') as String;
  @override
  set model(String value) => RealmObjectBase.set(this, 'model', value);

  @override
  double? get price => RealmObjectBase.get<double>(this, 'price') as double?;
  @override
  set price(double? value) => RealmObjectBase.set(this, 'price', value);

  @override
  int? get kilometers => RealmObjectBase.get<int>(this, 'kilometers') as int?;
  @override
  set kilometers(int? value) => RealmObjectBase.set(this, 'kilometers', value);

  @override
  Stream<RealmObjectChanges<CarA>> get changes =>
      RealmObjectBase.getChanges<CarA>(this);

  @override
  Stream<RealmObjectChanges<CarA>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CarA>(this, keyPaths);

  @override
  CarA freeze() => RealmObjectBase.freezeObject<CarA>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'make': make.toEJson(),
      'model': model.toEJson(),
      'price': price.toEJson(),
      'kilometers': kilometers.toEJson(),
    };
  }

  static EJsonValue _toEJson(CarA value) => value.toEJson();
  static CarA _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'make': EJsonValue make, 'model': EJsonValue model} => CarA(
        fromEJson(make),
        fromEJson(model),
        price: fromEJson(ejson['price'], defaultValue: 100000),
        kilometers: fromEJson(ejson['kilometers'], defaultValue: 500),
      ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CarA._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, CarA, 'CarA', [
      SchemaProperty('make', RealmPropertyType.string),
      SchemaProperty('model', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.double, optional: true),
      SchemaProperty('kilometers', RealmPropertyType.int, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
