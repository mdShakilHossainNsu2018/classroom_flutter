import 'package:classroom_flutter/constants/api_constant.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<http.Response> login(
      {required String username, required String password}) async {
    var response = await http.post(Uri.parse(K_LOGIN_URL),
        body: {"username": username, "password": password});
    return response;
  }

  Future<http.Response> signup(
      {required String username,
      required String password,
      required String email}) async {
    var response = await http.post(Uri.parse(K_REGISTRATION_URL), body: {
      "username": username,
      "password": password,
      "email": email,
      "is_staff": "false"
    });
    return response;
  }
}
