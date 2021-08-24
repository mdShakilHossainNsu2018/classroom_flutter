import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/constants/api_constant.dart';
import 'package:http/http.dart' as http;

class PostAPI {
  Future<http.Response> getPostByCourse({required String courseId}) async {
    String? token = Prefs.getLoggedInUserDetails().token;
    var response = await http.get(
        Uri.parse(
          K_GET_POST_BY_COURSE_ID,
        ).replace(queryParameters: {"course": courseId}),
        headers: {'Authorization': "Token $token"});
    return response;
  }
}
