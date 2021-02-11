import 'dart:async';
import 'dart:html' show window;
import 'package:academia_admin_panel/Screen/DashBoard/dashboard.dart';
import 'package:academia_admin_panel/Screen/Home/home_page.dart';
import 'package:academia_admin_panel/Screen/login.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'Screen/AcademicYear/academic_year_screen.dart';
import 'Screen/ManageClass/manage_class_screen.dart';
import 'Screen/ManageClass/src/student.dart';
import 'Screen/manage_class.dart';


void main() {
  setupLocator();
  runApp(MyApp());
}


void mainDelegate() async {

 
  /// register global error handler
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // FirebaseCrashlytics.instance.recordFlutterError;
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
  // Errors will never cross error-zone boundaries by themselves.
  // Errors that try to cross error-zone boundaries are considered uncaught in their originating error zone.
  //
  // More about zones:
  // - https://api.flutter.dev/flutter/dart-async/runZonedGuarded.html

  runZonedGuarded<Future<void>>(() async {
    runApp(MyApp());
  }, (error, stackTrace) {
    // Whenever an error occurs, call the `_reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    try {
     // reportErrorToSentry(error, stacktrace: stackTrace);
    } catch (e) {
      logger.e(e);
    }
  });

}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: InteractiveViewer(child: DashBoardPage("",2012)),//MaterialApp(home: Scaffold(body: StudentField()))//Academia(),
    );
  }
}

class Academia extends StatefulWidget {
  @override
  _AcademiaState createState() => _AcademiaState();
}

class _AcademiaState extends State<Academia> {

  @override
  Widget build(BuildContext context) {
    var token = window.localStorage.containsKey("token") ? window.localStorage["token"] : "";
    if(token != "") {
      print(token);
        return  AcademicYearPage(window.localStorage["userId"]);
    }
    else{
      window.localStorage.remove("token");
      return Login();
    }

  }
}



