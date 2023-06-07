import 'package:healing/Common/Constant.dart';
import 'package:healing/HttpProtocol/HttpExecute.dart';

class EndPoint {

  EndPoint();

  static login(String email, String password){
    Map parameters = {
      GRANT_TYPE: 'password',
      USERNAME: email,
      PASSWORD: password,
      AUDIENCE: URL_AUTH0 + API,
      SCOPE: 'offline_access openid',
      CLIENT_ID: APP_ID,
      CLIENT_SECRET: APP_SECRET,
    };

    return HttpExecute(URL_AUTH0, endpoint: '/oauth/token', parameters: parameters).post();
  }

  static getUser() {
    return HttpExecute(URL_AUTH0, endpoint: '/userinfo').get();
  }

  static refreshAccessToken(String refreshToken) {
    Map parameters = {
      GRANT_TYPE: 'refresh_token',
      REFRESH_TOKEN: refreshToken,
      CLIENT_ID: APP_ID,
      CLIENT_SECRET: APP_SECRET,
    };

    return HttpExecute(URL_AUTH0, endpoint: '/oauth/token', parameters: parameters, isRefresh: true).post();
  }
}