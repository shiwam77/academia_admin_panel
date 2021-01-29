// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';


//TODO: Must be extending error class and also stackTrace should be available

class ApiError extends Error {

  final int statusCode;
  final String status;
  final String message;
  final String errorCode;

  final String dioErrorMsg;
  final DioErrorType dioErrorType;

  ApiError(this.statusCode, [this.dioErrorMsg, this.dioErrorType, this.status, this.message, this.errorCode,]);

  String toString() {
    if (message != null && errorCode != null) {
      return '$message. Code($errorCode)';
    } else if (dioErrorMsg != null && dioErrorType != null) {
      if (dioErrorType == DioErrorType.CONNECT_TIMEOUT) {
        return 'Check your internet connection';
      }
      String dioErrorTypeStr = getDioErrorType();
      return '$dioErrorMsg. Type($dioErrorTypeStr)';
    } else if (message != null) {
      return '$message. HTTP($statusCode)';
    }
    return 'Something went wrong! Error($statusCode})';
  }


  String getDioErrorType() {
    return dioErrorType.toString().split(".").last;
  }

}