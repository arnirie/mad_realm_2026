import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_2026/car.dart';

void main() {
  runApp(RealmApp());
}

class RealmApp extends StatelessWidget {
  const RealmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SampleScreen());
  }
}

class SampleScreen extends StatelessWidget {
  SampleScreen({super.key});

  late Realm realm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ElevatedButton(onPressed: clickSample, child: Text('sample')),
      ),
    );
  }

  void clickSample() {
    var config = Configuration.local([CarA.schema]);
    realm = Realm(config);
    //car object
    // var car = CarA("mitsu", "xpander", kilometers: 200000);
    var results = realm.all<CarA>();
    realm.write(() {
      //write
      realm.delete(results.first);
      print('car delete');
    });
    results = realm.all<CarA>();
    results.forEach((item) {
      print(item.model);
    });
  }
}
