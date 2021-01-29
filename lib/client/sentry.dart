// import 'package:academia_admin_panel/utils/utils.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:sentry/sentry.dart';
// import 'package:device_info/device_info.dart';
// import 'package:package_info/package_info.dart';
// import 'package:battery/battery.dart';
//
// import 'package:spock/utils/utils.dart';
// import 'package:spock/config.dart';
//
// const String SENTRY_DSN = "https://580f1aaf4bfe484ebee37f9f2836d4f2@sentry.io/2688134";
//
// final SentryClient _sentry = new SentryClient(dsn: SENTRY_DSN);
//
//
// void reportDioErrorToSentry(DioError error) {
//   if (error.type != DioErrorType.CONNECT_TIMEOUT) {
//     if (error.error is Error) {
//       reportErrorToSentry(error.error, stacktrace: error.error.stackTrace);
//     }
//   }
// }
//
//
// Future<void> reportErrorToSentry(dynamic error, {dynamic stacktrace}) async {
//   // Print the exception to the console.
//   print('Caught error: $error');
//   if (isInDebugMode) {
//     // Print the full stacktrace in debug mode.
//     print(error);
//     print(stacktrace);
//     return;
//   } else {
//     // Send the Exception and Stacktrace to Sentry in Production mode.
//     _sentry.captureException(
//       exception: error,
//       stackTrace: stacktrace,
//     );
//   }
// }
//
//
// Future<void> reportExceptionToSentry(dynamic error) async {
//   // Print the exception to the console.
//   print('Caught error: $error');
//   if (isInDebugMode) {
//     // Print the full stacktrace in debug mode.
//     print(error);
//     return;
//   } else {
//     // Send the Exception and Stacktrace to Sentry in Production mode.
//     _sentry.captureException(exception: error);
//   }
// }
//
// SeverityLevel getSeverityLevelSentry(int level) {
//   switch(level) {
//     case -1:
//       return SeverityLevel.debug;
//     case 0:
//       return SeverityLevel.info;
//     case 1:
//       return SeverityLevel.warning;
//     case 2:
//       return SeverityLevel.error;
//     case 3:
//       return SeverityLevel.fatal;
//     default:
//       return SeverityLevel.info;
//   }
// }
//
//
//
//
// Future<void> reportEventToSentry(BuildContext buildContext, String loggerName,
//     String message, {int level = 0, List<Breadcrumb> breadcrumbs,
//       Map<String, dynamic> extras}) async {
//
//   Contexts contexts = await createContextsForSentry(buildContext);
//   String appVersion = await getAppVersion();
//
//   // Send the Event to sentry
//   if (isInDebugMode) {
//     // Print the full message in debug mode.
//     print("$appVersion -- $message");
//     return;
//   } else {
//     // Stopping usage of Sentry events
//     return;
//   }
// }
//
// Future<void> reportOnlyEventToSentry(String loggerName,
//     String message, {int level = 0, List<Breadcrumb> breadcrumbs,
//       Map<String, dynamic> extras}) async {
//
//   String appVersion = await getAppVersion();
//
//   // Send the Even to sentry
//   if (isInDebugMode) {
//     // Print the full message in debug mode.
//     print("$appVersion -- $message");
//     return;
//   } else {
//     // Stopping usage of Sentry events
//     return;
//   }
// }
//
