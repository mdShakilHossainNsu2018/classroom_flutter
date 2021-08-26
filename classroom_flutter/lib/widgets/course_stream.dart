import 'dart:convert';
import 'dart:developer';

import 'package:classroom_flutter/controller/apis/post_api.dart';
import 'package:classroom_flutter/models/courses_by_user_model.dart';
import 'package:classroom_flutter/models/post_model.dart';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:classroom_flutter/providers/posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class CourseStream extends StatefulWidget {
  const CourseStream({Key? key}) : super(key: key);

  @override
  _CourseStreamState createState() => _CourseStreamState();
}

class _CourseStreamState extends State<CourseStream> {
  PostAPI _postAPI = PostAPI();

  @override
  void initState() {
    super.initState();
    getCourseDetail();
  }

  getCourseDetail() async {
    CourseInfoModel? _currentCourse = context.read<Courses>().currentCourse;
    var res =
        await _postAPI.getPostByCourse(courseId: _currentCourse!.id.toString());

    if (res.statusCode == 200) {
      List<PostModel> _postList = (jsonDecode(res.body) as List)
          .map((e) => PostModel.fromJson(e))
          .toList();
      Provider.of<PostProvider>(context, listen: false).setPosts(_postList);
    }
    log(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<PostProvider>(
        builder: (context, items, child) {
          return ListView.builder(
            itemBuilder: (_, index) {
              return Card(
                elevation: 20,
                child: Text(items.posts[index].context!),
              );
            },
            itemCount: items.posts.length,
          );
        },
      ),
    );
  }
}
