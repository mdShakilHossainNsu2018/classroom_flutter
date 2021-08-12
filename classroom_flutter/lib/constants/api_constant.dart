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
