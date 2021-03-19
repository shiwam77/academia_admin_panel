import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:academia_admin_panel/services/middleware.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:dio/dio.dart';



typedef ResponseSerializer = dynamic Function(Map<String, dynamic> json);

Future getHttpServiceFuture(String requestUrl, responseSerializer,
    {Map<String, String> queryParams,String apiHostedUrl, returnRaw: false, }) async {

  HttpMiddleware httpMiddleware = HttpMiddleware();
  Response httpResponse;
  DioError dioError;

  if (apiHostedUrl == null) {
    apiHostedUrl = Api.apiHostedUrl;
  }

  try {
    Dio http = await httpMiddleware.getHttpClient(apiHostedUrl,responseSerializer: responseSerializer,);
    httpResponse = await http.get(requestUrl, queryParameters: queryParams,);

  } on DioError catch (error) {
    dioError = error;
    if (error.response != null) {
      httpResponse = error.response;
    }

    if (error.error is ApiError) {
      return Future.error(error.error);
    } else {

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

      return responseJson;
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
              responseObject.errorCode,
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
              responseObject.status, responseObject.message,
              responseObject.errorCode,
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
              responseObject.status, responseObject.message,
              responseObject.errorCode,
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
    httpResponse = await http.delete(requestUrl, queryParameters: queryParams);

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
        print("try");
        responseObject = responseSerializer(responseJson);
      } catch (error, stackTrace) {
        print("try next");
        serviceErrorLogger(error, stackTrace);
        return Future.error(ApiError(0));
      }
    }

    if (isJson && responseObject != null) {
      print("isjson");
      if (httpStatusCode == 204 && responseObject.status == "success") {
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
    print("dio erroe");
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
    String message = "";
    String errorCode = "NA";
    Map<String,dynamic> errorData = {};
    dynamic data = {};

    if(responseJson is Map){
      status = responseJson.containsKey('status') ? responseJson['status'] as String : 'Something went wrong';
      message = responseJson.containsKey('message') ? responseJson['message'] as String : 'Something went wrong';
      errorCode = responseJson.containsKey('errorCode') ? responseJson['errorCode'] as String : 'NA';
      data = responseJson.containsKey('data') ? responseJson['data'] : null;
    }


    if(responseCode >= 200 && responseCode < 300 && status == 'success'){
      return data;
    }else{
      throw ApiError(responseCode, "", DioErrorType.DEFAULT, status, message, errorCode,);
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

// Future<String> uploadImage({dynamic file ,String apiHostedUrl,String reuestedUrl}) async {

//      HttpMiddleware httpMiddleware = HttpMiddleware();
//       Response response;
//        if (apiHostedUrl == null) {
//         apiHostedUrl = Api.apiHostedUrl;
//       }

//       try{
//         Dio http = await httpMiddleware.getHttpClient(apiHostedUrl,);
//         String fileName = file.path.split('/').last;
//         print("upload file");
//         print(file.path);
//           FormData formData = FormData.fromMap({
//           "name_image":fileName,
         
//           "image": await MultipartFile.fromFile(file.path, filename:fileName, ),
//     });
//         response = await http.post("/info", data: formData);
//       }catch(error){
//        print(error);
//       }
  
//     return response.data['id'];
// }

// Future<String> uploadImage({dynamic file ,String apiHostedUrl,String reuestedUrl}) async {
//
//      HttpMiddleware httpMiddleware = HttpMiddleware();
//       Response response;
//        if (apiHostedUrl == null) {
//         apiHostedUrl = Api.apiHostedUrl;
//       }
//
//       try{
//          var stream = ByteStream(DelegatingStream(file.openRead()));
//         Dio http = await httpMiddleware.getHttpClient(apiHostedUrl,);
//         String fileName = file.path.split('/').last;
//
//           FormData formData = FormData.fromMap({
//           "name_image":fileName,
//
//           "image": await MultipartFile.fromFile(file.path, filename:fileName, contentType: MediaType('image', 'png')),
//     });
//         response = await http.post("/info", data: formData);
//       }catch(error){
//        print(error);
//       }
//
//     return response.data['id'];
// }

Future<bool> uploadImages(
    String imageFilePath,
    Uint8List imageBytes,
  ) async {
    String url =  Api.apiHostedUrl + "/info";
    PickedFile imageFile = PickedFile(imageFilePath);
    var stream =
        new http.ByteStream(DelegatingStream(imageFile.openRead()));

    var uri = Uri.parse(url);
    int length = imageBytes.length;
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('files', stream, length,
        filename: basename(imageFile.path),
        contentType: MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.stream);
  }