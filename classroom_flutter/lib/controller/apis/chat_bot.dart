import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/constants/api_constant.dart';
import 'package:http/http.dart' as http;

class ChatBOTAPI {
  Future<http.Response> getChatBOTResponse({required String text}) async {
    String? token = Prefs.getLoggedInUserDetails().token;
    var response = await http.post(
        Uri.parse(
          K_GET_CHATBOT_RESPONSE,
        ),
        body: {"text": text},
        headers: {'Authorization': "Token $token"});
    return response;
  }
}