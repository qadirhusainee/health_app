import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:health_app/screens/OnBoarding.dart';
import 'package:health_app/screens/Login.dart';
import 'package:health_app/utils/Config.dart';
import 'package:health_app/utils/sharedPreferences.dart';

bool renderingFirstTime;
void main() async {
  // Uncomment if want to genreate crash logs on debug mode
  // Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  try {
    renderingFirstTime = await getBoolPreference(Config.renderingFirstTimeKey) ?? true;
  } catch (error) {
    renderingFirstTime = true;
  }

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
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      routes: {
        '/': (context) {
          if (renderingFirstTime) {
            return OnBoarding();
          } else {
            return Login();
          }
        },
        OnBoarding.routeName: (context) => OnBoarding(),
        Login.routeName: (context) => Login()
      },
    );
  }
}
