import 'package:classroom_flutter/models/post_model.dart';
import 'package:flutter/cupertino.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> _posts = [];

  void setPosts(List<PostModel> posts) {
    _posts = posts;
    notifyListeners();
  }

  List<PostModel> get posts {
    return _posts;
  }
}
