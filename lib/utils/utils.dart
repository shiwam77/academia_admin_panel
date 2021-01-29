
import 'dart:html';

import 'package:academia_admin_panel/Model/user_model.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

var logger = Logger();
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

    UserModel user = UserModel(password, email);
    var dio = Dio();
    Response response = await dio.post('${AuthApi.login}',data: user.toJson());

    if(response.statusCode == 200){
      var data = GetUserAuth.fromJson(response.data);
      return data.token;
    }
    else{
      return "";
    }
}

Future<String> attemptSignUp({String email,String password,String passwordConfirm,String name}) async{
  Map<String,String> user ={
    "email":email,
    "password":password,
    "passwordConfirm":passwordConfirm,
    "name":name,
  };
  print(email);
  var dio = Dio();
  print(AuthApi.signUp);
  Response response = await dio.post('${AuthApi.signUp}',data: user);

  if(response.statusCode == 201){
    var data = GetUserAuth.fromJson(response.data);
    return data.token;
  }
  else{
    return "";
  }
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