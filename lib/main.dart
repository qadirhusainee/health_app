import 'package:flutter/material.dart';
import 'package:health_app/screens/OnBoarding.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  // Uncomment if want to genreate crash logs on debug mode
  // Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoarding(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      // initialRoute: OnBoarding.routeName,
      // routes: {
      //   OnBoarding.routeName: () => OnBoarding(),
      //   Login.routeName : () => Login()
      // },
    );
  }
}
