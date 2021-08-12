import 'package:classroom_flutter/controller/apis/user_api.dart';

class UserController {
  UserApi _userApi = UserApi();

  // Future<LoginDataModel> getLoginData(
  //     {required String username, required String password}) async {
  //   var response = await _userApi.login(username: username, password: password);
  //   return LoginDataModel.fromJson(jsonDecode(response));
  // }
}
