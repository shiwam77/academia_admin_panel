class Api {
  static const apiVNone = "";
  static const apiV1 = "/v1";
  static const apiV2 = "/v2";

  static String get apiHostedUrl {
    return "http://127.0.0.1:3000";
  }
}

class AuthApi {

  static String get  apiView {
    return Api.apiHostedUrl +"/auth";
  }

  static String get login {
    return apiView + Api.apiV1 + "/login";
  }

  static String get signUp {
    return apiView + Api.apiV1 + "/signup";
  }

  static String get forgoPassword {
    return apiView + Api.apiV1 + "/forgotPassword";
  }

  static String get resetPassword {
    return apiView + Api.apiV1 + "/resetPassword";
  }
}