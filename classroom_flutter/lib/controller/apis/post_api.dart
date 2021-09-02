import 'dart:io';

import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/constants/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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

  Future<http.StreamedResponse> createPost({
    required String courseId,
    required String context,
    File? file,
    DateTime? dateTime,
    required String type,
  }) async {
    String? token = Prefs.getLoggedInUserDetails().token;
    var postUri = Uri.parse(K_CREATE_POST);

    Map<String, String> headers = {
      'content-type': 'multipart/form-data',
      'Authorization': "Token $token"
    }; // ignore this headers if there is no authentication

    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

    if (file?.path != null) {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('attachment', file!.path);
      request.files.add(multipartFile);
    }

    request.fields['user'] = Prefs.getLoggedInUserDetails().id.toString();
    request.fields['course'] = courseId;
    request.fields['type'] = type.toLowerCase();
    request.fields['context'] = context;
    if (dateTime != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      request.fields['due_date'] = formatter.format(dateTime);
      request.fields['due_time'] = DateFormat.Hms().format(dateTime);
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // print(response.statusCode);

    return response;
  }

  Future<http.Response> postComment(
      {required String postID, required String comment}) async {
    //                     user: this.getUserId,
//                     post: postId,
//                     comment: this.comment
    String? token = Prefs.getLoggedInUserDetails().token;

    var response = await http.post(Uri.parse(K_CREATE_COMMENT), body: {
      "user": Prefs.getLoggedInUserDetails().id.toString(),
      "post": postID,
      "comment": comment,
    }, headers: {
      'Authorization': "Token $token",
    });
    return response;
  }
}
