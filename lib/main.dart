import 'package:flutter/material.dart';
import 'package:health_app/screens/OnBoarding.dart';
import 'package:health_app/screens/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoarding(),
      // initialRoute: OnBoarding.routeName,
      // routes: {
      //   OnBoarding.routeName: () => OnBoarding(),
      //   Login.routeName : () => Login()
      // },
    );
  }
}
