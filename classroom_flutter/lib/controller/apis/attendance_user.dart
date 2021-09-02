import 'dart:convert';

import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/constants/api_constant.dart';
import 'package:classroom_flutter/models/attendance_model.dart';
import 'package:http/http.dart' as http;

class AttendanceAPI {
  // K_GET_ATTENDANCE_BY_COURSE

  Future<http.Response> getAttendace({required String courseId}) async {
    // {user: this.getUserId, course: this.id}
    String? token = Prefs.getLoggedInUserDetails().token;
    String? id = Prefs.getLoggedInUserDetails().id.toString();
    var response = await http.get(
        Uri.parse(
          K_GET_ATTENDANCE_BY_COURSE,
        ).replace(queryParameters: {"course": courseId, "user": id}),
        headers: {'Authorization': "Token $token"});
    return response;
  }

  Future<http.Response> postAttendance(
      {required List<AttendanceModel> attendanceList}) async {
    // print(jsonEncode(attendanceList));
    String? token = Prefs.getLoggedInUserDetails().token;

    var response = await http.post(Uri.parse(K_POST_ATTENDANCE),
        body: jsonEncode(attendanceList),
        headers: {
          'Authorization': "Token $token",
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    return response;
  }
}
