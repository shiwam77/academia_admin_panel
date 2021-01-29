import 'dart:async';
import 'dart:convert';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:academia_admin_panel/services/middleware.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:dio/dio.dart';



typedef ResponseSerializer = dynamic Function(Map<String, dynamic> json);

Future getHttpServiceFuture(String requestUrl, responseSerializer,
    {Map<String, String> queryParams,String apiHostedUrl, returnRaw: false, int cacheMaxMin: 15}) async {

  HttpMiddleware httpMiddleware = HttpMiddleware();
  Response httpResponse;
  DioError dioError;

  if (apiHostedUrl == null) {
    apiHostedUrl = Api.apiHostedUrl;
  }

  try {
    Dio http = await httpMiddleware.getHttpClient(apiHostedUrl, );
    httpResponse = await http.get(requestUrl, queryParameters: queryParams,);

  } on DioError catch (error) {
    dioError = error;
    if (error.response != null) {
      httpResponse = error.response;
    }

    if (error.error is ApiError) {
      return Future.error(error.error);
    } else {
      // logCrashlyticsDioError(error);
      // reportDioErrorToSentry(error);
      print(error);
    }
  }


  if (httpResponse != null && httpResponse.data != null) {

    bool isJson = false;
    if (httpResponse.headers != null) {
      isJson = (httpResponse.headers['content-type'] != null) && httpResponse.headers['content-type'].contains('application/json');
    }

    int httpStatusCode = httpResponse.statusCode;
    var responseJson = httpResponse.data, responseObject;

    if(returnRaw){
      return {'responseJson': responseJson,'httpStatusCode': httpStatusCode};
    }

    if (isJson) {
      try {
        responseObject = responseSerializer(responseJson);
      } catch (error, stackTrace) {
        // Error HTTP Code 5XX
        serviceErrorLogger(error, stackTrace);
        return Future.error(ApiError(0));
      }
    }

    if (isJson && responseObject != null) {
      if (httpStatusCode == 200 && responseObject.status == "success") {
        return responseObject;
      }
      return Future.error(
          ApiError(
              httpStatusCode,
              dioError.message, dioError.type,
              responseObject.status, responseObject.mess,
              responseObject.error_code,
          )
      );
    }

    return Future.error(
        ApiError(
            httpStatusCode,
            dioError.message, dioError.type,
            httpResponse.statusMessage, httpResponse.data.toString()
        )
    );
  }

  if (dioError != null) {
    return Future.error(ApiError(0, dioError.message, dioError.type));
  }
  return Future.error(ApiError(0));
}


Future postHttpServiceFuture(String requestUrl, responseSerializer,
    {Map<String, String> queryParams, Map postData,
      bool enableCache: false, String apiHostedUrl, returnRaw: false, isForm: false, int cacheMaxMin: 15}) async {

  HttpMiddleware httpMiddleware = HttpMiddleware();
  Response httpResponse;
  DioError dioError;
  var encodedBody;
  if (!isForm) {
    encodedBody = json.encode(postData);
  } else {
    encodedBody = FormData.fromMap(postData);
  }

  if (apiHostedUrl == null) {
    apiHostedUrl = Api.apiHostedUrl;
  }

  try {
    Dio http = await httpMiddleware.getHttpClient(apiHostedUrl,);
    httpResponse = await http.post(requestUrl, data: encodedBody, queryParameters: queryParams,);

  } on DioError catch (error, stackTrace) {
    dioError = error;
    serviceErrorLogger(error, stackTrace);
    if (dioError.response != null) {
      httpResponse = dioError.response;
    }
    if (error.error is ApiError) {
      return Future.error(error.error);
    }
  }

  if (httpResponse != null && httpResponse.data != null) {

    bool isJson = false;
    if (httpResponse.headers != null) {
      isJson = (httpResponse.headers['content-type'] != null) && httpResponse.headers['content-type'].contains('application/json');
    }

    int httpStatusCode = httpResponse.statusCode;
    var responseJson = httpResponse.data, responseObject;

    if(returnRaw){
      return {'responseJson': responseJson,'httpStatusCode': httpStatusCode};
    }

    if (isJson) {
      try {
        responseObject = responseSerializer(responseJson);
      } catch (error, stackTrace) {
        serviceErrorLogger(error, stackTrace);
        return Future.error(ApiError(0));
      }
    }

    if (isJson && responseObject != null) {
      if (httpStatusCode == 200 && responseObject.status == "success") {
        return responseObject;
      }
      return Future.error(
          ApiError(
              httpStatusCode,
              dioError.message, dioError.type,
              responseObject.status, responseObject.msg,
              responseObject.error_code,
          )
      );
    }

    return Future.error(
        ApiError(
            httpStatusCode,
            dioError.message, dioError.type,
            httpResponse.statusMessage, httpResponse.data.toString()
        )
    );
  }

  if (dioError != null) {
    logger.e("Dio Error is null");
    return Future.error(ApiError(0, dioError.message, dioError.type));
  }
  return Future.error(ApiError(0));
}

Future putHttpServiceFuture(String requestUrl, responseSerializer,
    {Map<String, String> queryParams, Map postData,
      bool enableCache: false, String apiHostedUrl, returnRaw: false}) async {

  HttpMiddleware httpMiddleware = HttpMiddleware();
  Response httpResponse;
  DioError dioError;
  String encodedBody = json.encode(postData);

  if (apiHostedUrl == null) {
    apiHostedUrl = Api.apiHostedUrl;
  }

  try {
    Dio http = await httpMiddleware.getHttpClient(apiHostedUrl);
    httpResponse = await http.put(requestUrl, data: encodedBody, queryParameters: queryParams);

  } on DioError catch (error, stackTrace) {
    dioError = error;
    serviceErrorLogger(error, stackTrace);
    if (dioError.response != null) {
      httpResponse = dioError.response;
    }
    if (error.error is ApiError) {
      return Future.error(error.error);
    }
  }

  if (httpResponse != null && httpResponse.data != null) {

    bool isJson = false;
    if (httpResponse.headers != null) {
      isJson = (httpResponse.headers['content-type'] != null) && httpResponse.headers['content-type'].contains('application/json');
    }

    int httpStatusCode = httpResponse.statusCode;
    var responseJson = httpResponse.data, responseObject;

    if(returnRaw){
      return {'responseJson': responseJson,'httpStatusCode': httpStatusCode};
    }

    if (isJson) {
      try {
        responseObject = responseSerializer(responseJson);
      } catch (error, stackTrace) {
        serviceErrorLogger(error, stackTrace);
        return Future.error(ApiError(0));
      }
    }

    if (isJson && responseObject != null) {
      if (httpStatusCode == 200 && responseObject.status == "success") {
        return responseObject;
      }
      return Future.error(
          ApiError(
              httpStatusCode,
              dioError.message, dioError.type,
              responseObject.status, responseObject.msg,
              responseObject.error_code,
          )
      );
    }

    return Future.error(
        ApiError(
            httpStatusCode,
            dioError.message, dioError.type,
            httpResponse.statusMessage, httpResponse.data.toString()
        )
    );
  }

  if (dioError != null) {
    logger.e("Dio Error is null");
    return Future.error(ApiError(0, dioError.message, dioError.type));
  }
  return Future.error(ApiError(0));
}

Future patchHttpServiceFuture(String requestUrl, responseSerializer,
    {Map<String, String> queryParams, Map postData,
       String apiHostedUrl, returnRaw: false}) async {

  HttpMiddleware httpMiddleware = HttpMiddleware();
  Response httpResponse;
  DioError dioError;
  String encodedBody = json.encode(postData);

  if (apiHostedUrl == null) {
    apiHostedUrl = Api.apiHostedUrl;
  }

  try {
    Dio http = await httpMiddleware.getHttpClient(apiHostedUrl);
    httpResponse = await http.patch(requestUrl, data: encodedBody, queryParameters: queryParams);

  } on DioError catch (error, stackTrace) {
    dioError = error;
    serviceErrorLogger(error, stackTrace);
    if (dioError.response != null) {
      httpResponse = dioError.response;
    }
    if (error.error is ApiError) {
      return Future.error(error.error);
    }
  }

  if (httpResponse != null && httpResponse.data != null) {

    bool isJson = false;
    if (httpResponse.headers != null) {
      isJson = (httpResponse.headers['content-type'] != null) && httpResponse.headers['content-type'].contains('application/json');
    }

    int httpStatusCode = httpResponse.statusCode;
    var responseJson = httpResponse.data, responseObject;

    if(returnRaw){
      return {'responseJson': responseJson,'httpStatusCode': httpStatusCode};
    }

    if (isJson) {
      try {
        responseObject = responseSerializer(responseJson);
      } catch (error, stackTrace) {
        serviceErrorLogger(error, stackTrace);
        return Future.error(ApiError(0));
      }
    }

    if (isJson && responseObject != null) {
      if (httpStatusCode == 200 && responseObject.status == "success") {
        return responseObject;
      }
      return Future.error(
          ApiError(
              httpStatusCode,
              dioError.message, dioError.type,
              responseObject.status, responseObject.msg,
              responseObject.error_code,
          )
      );
    }

    return Future.error(
        ApiError(
            httpStatusCode,
            dioError.message, dioError.type,
            httpResponse.statusMessage, httpResponse.data.toString()
        )
    );
  }

  if (dioError != null) {
    logger.e("Dio Error is null");
    return Future.error(ApiError(0, dioError.message, dioError.type));
  }
  return Future.error(ApiError(0));
}

Future deleteHttpServiceFuture(String requestUrl, responseSerializer,
    {Map<String, String> queryParams, Map postData,
      String apiHostedUrl, returnRaw: false}) async {

  HttpMiddleware httpMiddleware = HttpMiddleware();
  Response httpResponse;
  DioError dioError;
  String encodedBody = json.encode(postData);

  if (apiHostedUrl == null) {
    apiHostedUrl = Api.apiHostedUrl;
  }

  try {
    Dio http = await httpMiddleware.getHttpClient(apiHostedUrl);
    httpResponse = await http.delete(requestUrl, data: encodedBody, queryParameters: queryParams);

  } on DioError catch (error, stackTrace) {
    dioError = error;
    serviceErrorLogger(error, stackTrace);
    if (dioError.response != null) {
      httpResponse = dioError.response;
    }
    if (error.error is ApiError) {
      return Future.error(error.error);
    }
  }

  if (httpResponse != null && httpResponse.data != null) {

    bool isJson = false;
    if (httpResponse.headers != null) {
      isJson = (httpResponse.headers['content-type'] != null) && httpResponse.headers['content-type'].contains('application/json');
    }

    int httpStatusCode = httpResponse.statusCode;
    var responseJson = httpResponse.data, responseObject;

    if(returnRaw){
      return {'responseJson': responseJson,'httpStatusCode': httpStatusCode};
    }

    if (isJson) {
      try {
        responseObject = responseSerializer(responseJson);
      } catch (error, stackTrace) {
        serviceErrorLogger(error, stackTrace);
        return Future.error(ApiError(0));
      }
    }

    if (isJson && responseObject != null) {
      if (httpStatusCode == 200 && responseObject.status == "success") {
        return responseObject;
      }
      return Future.error(
          ApiError(
              httpStatusCode,
              dioError.message, dioError.type,
              responseObject.status, responseObject.msg,
              responseObject.error_code,
          )
      );
    }

    return Future.error(
        ApiError(
            httpStatusCode,
            dioError.message, dioError.type,
            httpResponse.statusMessage, httpResponse.data.toString()
        )
    );
  }

  if (dioError != null) {
    logger.e("Dio Error is null");
    return Future.error(ApiError(0, dioError.message, dioError.type));
  }
  return Future.error(ApiError(0));
}




class HttpCalls {

  static Future get(String requestUrl, {Map<String, String> queryParams,  String apiHostedUrl}) async{
    dynamic json = await getHttpServiceFuture(requestUrl, HttpCalls._fake_serializer, queryParams: queryParams, apiHostedUrl: apiHostedUrl, returnRaw: true);
    return _parseResponse(json);
  }

  static Future post(String requestUrl, {Map<String, String> queryParams, Map postData,  String apiHostedUrl}) async {
    dynamic json =  await postHttpServiceFuture(requestUrl, HttpCalls._fake_serializer,queryParams: queryParams, postData: postData,  apiHostedUrl: apiHostedUrl, returnRaw: true);
    return _parseResponse(json);
  }

  static Future patch(String requestUrl, {Map<String, String> queryParams, Map postData,  String apiHostedUrl}) async {
    dynamic json =  await patchHttpServiceFuture(requestUrl, HttpCalls._fake_serializer,queryParams: queryParams, postData: postData,  apiHostedUrl: apiHostedUrl, returnRaw: true);
    return _parseResponse(json);
  }

  static Future put(String requestUrl, {Map<String, String> queryParams, Map postData,  String apiHostedUrl}) async {
    dynamic json = await putHttpServiceFuture(requestUrl, HttpCalls._fake_serializer,queryParams: queryParams, postData: postData,  apiHostedUrl: apiHostedUrl, returnRaw: true);
    return _parseResponse(json);
  }

  static Future delete(String requestUrl, {Map<String, String> queryParams, Map postData, String apiHostedUrl}) async {
    dynamic json = await deleteHttpServiceFuture(requestUrl, HttpCalls._fake_serializer,queryParams: queryParams,postData: postData,  apiHostedUrl: apiHostedUrl, returnRaw: true);
    return _parseResponse(json);
  }


  static _parseResponse(dynamic json){

    int responseCode = json['httpStatusCode'] as int;

    var responseJson = json['responseJson'];

    // default values
    String status = "";
    String msg = "";
    String errorCode = "NA";
    Map<String,dynamic> errorData = {};
    dynamic data = {};

    if(responseJson is Map){
      status = responseJson.containsKey('status') ? responseJson['status'] as String : 'Something went wrong';
      msg = responseJson.containsKey('message') ? responseJson['message'] as String : 'Something went wrong';
      errorCode = responseJson.containsKey('errorCode') ? responseJson['errorCode'] as String : 'NA';
      data = responseJson.containsKey('data') ? responseJson['data'] : null;
    }


    if(responseCode >= 200 && responseCode < 300 && status == 'success'){
      return data;
    }else{
      throw ApiError(responseCode, "", DioErrorType.DEFAULT, status, msg, errorCode,);
    }
  }

  // fake serializer

  static ResponseSerializer _fake_serializer = (Map<String,dynamic> args)=> null;

}

void serviceErrorLogger(error, stackTrace) {
  List<String> ignoreErrorCodes = ["INVALID_TOKEN", "EXPIRED_REFRESH_TOKEN"];
  if (error is ApiError && error.errorCode != null &&
      ignoreErrorCodes.contains(error.errorCode)) {
    logger.w(error);
  } else {
    logger.e(error);
  }
}