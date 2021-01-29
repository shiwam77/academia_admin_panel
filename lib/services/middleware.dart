
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:dio/dio.dart';

class HttpMiddleware {
  Dio dio = new Dio();

  Future<Dio> getHttpClient(baseUrl,
      {responseSerializer,}) async {
    var accessToken = getAccessToken();
    dio.options.baseUrl = baseUrl;

    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        // Do something before request is sent
        String requestUrl = options.baseUrl + options.path;
          options.headers['Authorization'] = 'Bearer $accessToken';
        return options; //continue
        // If you want to resolve the request with some custom data，
        // you can return a `Response` object or return `dio.resolve(data)`.
        // If you want to reject the request with a error message,
        // you can return a `DioError` object or return `dio.reject(errMsg)`
      },
        onError: (DioError error) async {
          // Do something with response error

          if (error.response != null && error.type == DioErrorType.RESPONSE) {
            if (error.response.statusCode == 401 && error.response.data != null) {
              List<String> tokenRefreshErrors = ['EXPIRED_SIGNATURE'];
              var serverErrorJson = error.response.data;
              if(serverErrorJson.containsKey('errorCode') &&
                  serverErrorJson['errorCode'] != null &&
                  tokenRefreshErrors.contains(serverErrorJson['errorCode'])) {
                return error;
              }
            }
          }
          return error;
        }
    ));
    return dio;
  }
}