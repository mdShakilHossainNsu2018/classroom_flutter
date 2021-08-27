import 'dart:io' show Platform;

// const String IP = "192.168.0.104";
const String IP = "192.168.0.108";

String getIP() {
  if (Platform.isAndroid || Platform.isIOS) {
    return IP;
  } else {
    return "localhost";
  }
}

String K_BASE_URL = "http://${getIP()}:8000/api/";
String K_LOGIN_URL = "${K_BASE_URL}users/token-auth/";
String K_REGISTRATION_URL = "${K_BASE_URL}users/users/";
String K_GET_USER_BY_COURSE_URL =
    "${K_BASE_URL}users/user_by_course/"; // get, course required
String K_GET_COURSES_URL =
    "${K_BASE_URL}courses/user_course/"; // get method, token
String K_GET_COURSE_URL =
    "${K_BASE_URL}courses/courses/"; // get method, id, token

String K_GET_COURSE_BY_ID(String id) {
  return "${K_GET_COURSE_URL}${id}/";
}

String K_GET_POST_BY_COURSE_ID = "${K_BASE_URL}post/";

String K_GET_CHATBOT_RESPONSE =
    "${K_BASE_URL}chatbot/"; // post method, text required

String K_GET_ATTENDANCE_BY_COURSE = "${K_BASE_URL}attendance/";
