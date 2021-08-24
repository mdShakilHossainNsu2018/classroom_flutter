import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/constants/api_constant.dart';
import 'package:http/http.dart' as http;

class CourseApi {
  Future<http.Response> getCourses({required String token}) async {
    var response = await http.get(Uri.parse(K_GET_COURSES_URL),
        headers: {'Authorization': "Token $token"});
    return response;
  }

  Future<http.Response> getCoursesById({required String id}) async {
    String? token = Prefs.getLoggedInUserDetails().token;
    var response = await http.get(Uri.parse(K_GET_COURSE_BY_ID(id)),
        headers: {'Authorization': "Token $token"});
    return response;
  }
}
