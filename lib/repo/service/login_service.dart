import 'package:flutter_auth_getx/repo/model/login_request_model.dart';
import 'package:flutter_auth_getx/repo/model/login_response_model.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class LoginService extends GetConnect {
  final String loginUrl = 'http://mobiletest.seventh.com.br/login';

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson());
    print("AAAAAAAAAAAAAAAA");
    print(response.body);
    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
