import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

// const String IP = "192.168.0.104";
const String IP = "192.168.0.108";

String getIP() {
  // if ((defaultTargetPlatform == TargetPlatform.iOS) ||
  //     (defaultTargetPlatform == TargetPlatform.android)) {
  //   // Some android/ios specific code
  //   return IP;
  // } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
  //     (defaultTargetPlatform == TargetPlatform.macOS) ||
  //     (defaultTargetPlatform == TargetPlatform.windows)) {
  //   // Some desktop specific code there
  //   return IP;
  // } else {
  //   // Some web specific code there
  //   return "localhost";
  // }
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      return IP;
    } else {
      return "localhost";
    }
  } catch (e) {
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

// attendance/create/
String K_POST_ATTENDANCE = "${K_BASE_URL}attendance/create/"; // post,

String K_CREATE_POST = "${K_BASE_URL}post/create/"; // post

//  const comment = {

//                     user: this.getUserId,
//                     post: postId,
//                     comment: this.comment

//                 }
// post/comment/
String K_CREATE_COMMENT = "${K_BASE_URL}post/comment/"; // post