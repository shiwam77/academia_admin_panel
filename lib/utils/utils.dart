
import 'dart:html';

import 'package:academia_admin_panel/Model/user_model.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

var logger = Logger();
var dio = Dio();
bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  return packageName + ":" + version + "(" + buildNumber + ")";
}

Future<String> attemptLogin({String email,String password}) async{
  var dio = Dio();
    UserModel user = UserModel(password:password, email:email);

    return await dio.post('${AuthApi.login}',data: user.toJson()).then((response) {
       if(response.statusCode == 200){
         var data = GetUserAuth.fromJson(response.data);
         window.localStorage["userId"] = data.userId;
         window.localStorage["userName"] = data.user.name;
         return data.token;
       }
       else if(response.statusCode == 401){
         return "";
       }
    }).catchError((err){
      print(err);
       return "";
    });

}

Future<String> attemptSignUp({String email,String password,String passwordConfirm,String name}) async{
  var dio = Dio();
  Map<String,String> user ={
    "email":email,
    "password":password,
    "passwordConfirm":passwordConfirm,
    "name":name,
    "userType":"admin"
  };
  print(email);

  print(AuthApi.signUp);
  return await dio.post('${AuthApi.signUp}',data: user).then((response) {
    if(response.statusCode == 201){
      var data = GetUserAuth.fromJson(response.data);
      window.localStorage["userId"] = data.userId;
      window.localStorage["userName"] = data.user.name;
      return data.token;
    }
    else{
      return "";
    }
  }).catchError((error){
    print(error);
    return "";
  });

}

Future<bool> createUser({String email,String password,String passwordConfirm,String name}) async{
  var dio = Dio();
  Map<String,String> user ={
    "email":email,
    "password":password,
    "passwordConfirm":passwordConfirm,
    "name":name,
    "userType":"user"
  };
  print(email);

  print(AuthApi.signUp);
  return await dio.post('${AuthApi.signUp}',data: user).then((response) {
    print(response);
    if(response.statusCode == 201 ){
      return true;
    }
    else{
      return false;
    }
  }).catchError((error){
    print(error);
    return false;
  });

}

Future<bool> updateUser({String email,String password,String passwordConfirm,String name}) async{
  var dio = Dio();
  Map<String,String> user ={
    "email":email,
    "password":password,
    "passwordConfirm":passwordConfirm,
    "name":name,
    "userType":"user"
  };
  print(email);

  print(AuthApi.signUp);
  return await dio.post('${AuthApi.signUp}',data: user).then((response) {
    print(response);
    if(response.statusCode == 201 ){
      return true;
    }
    else{
      return false;
    }
  }).catchError((error){
    print(error);
    return false;
  });

}
String getAccessToken(){
  var token = window.localStorage.containsKey("token") ? window.localStorage["token"] : "";
  if(token != ""){
    return token;
  }
  else{
    return "";
  }
}

String emailValidator(String email){

  bool isValid = EmailValidator.validate(email);
  if(isValid == true){
    return null;
  }
  else{
    return "Please provide a valid email address";
  }
}

logout(){
  if(window.localStorage.containsKey("token")){
    window.localStorage.remove("token");
  }
}

  void showToast(BuildContext context, String text,
    {String action = "OK", Color color, Function toastAction }) {
  // SnackBar not showing? Try: https://stackoverflow.com/a/51304732/5129047

  final scaffold =  Scaffold.of(context);

  if(color != null){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
        action: SnackBarAction(
          label: action,
          onPressed:  toastAction != null
              ? toastAction
              : scaffold.hideCurrentSnackBar,
          textColor: Colors.white,
        ),
      ),
    );
  } else {

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: action,
          onPressed:  toastAction != null
              ? toastAction
              : scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }

}