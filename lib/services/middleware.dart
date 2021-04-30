
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:dio/dio.dart';

class HttpMiddleware {
  Dio dio = new Dio();

  Future<Dio> getHttpClient(baseUrl,
      {responseSerializer,Map<String, String> queryParams}) async {
    var accessToken = getAccessToken();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 60000; //60s
    dio.options.receiveTimeout = 60000;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        print("token for opn $accessToken");
        // Do something before request is sent
        String requestUrl = options.baseUrl + options.path;
          options.headers['Authorization'] = 'Bearer $accessToken';
        return options; //continue
      },
        onError: (DioError error) async {
          return error;
        }
    ));
    return dio;
  }
}