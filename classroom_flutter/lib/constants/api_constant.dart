import 'dart:io' show Platform;

const String IP = "192.168.0.104";

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
String K_GET_USER_BY_COURSE_URL = "${K_BASE_URL}users/user_by_course/";
String K_GET_COURSES_URL =
    "${K_BASE_URL}courses/user_course/"; // get method, token
String K_GET_COURSE_URL =
    "${K_BASE_URL}courses/courses/"; // get method, id, token
