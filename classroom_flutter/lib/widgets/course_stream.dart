import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:classroom_flutter/constants/constants.dart';
import 'package:classroom_flutter/controller/apis/post_api.dart';
import 'package:classroom_flutter/models/courses_by_user_model.dart';
import 'package:classroom_flutter/models/post_model.dart';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:classroom_flutter/providers/posts.dart';
import 'package:classroom_flutter/snippets/loading_indicator.dart';
import 'package:classroom_flutter/utils/date_time_convater.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseStream extends StatefulWidget {
  const CourseStream({Key? key}) : super(key: key);

  @override
  CourseStreamState createState() => CourseStreamState();
}

class CourseStreamState extends State<CourseStream> {
  PostAPI _postAPI = PostAPI();
  LoadingIndicator _loadingIndicator = LoadingIndicator();
  late String comment;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    new Future.delayed(Duration.zero, () {
      getCourseDetail(context);
    });
  }

  getCourseDetail(BuildContext context) async {
    _loadingIndicator.showLoadingIndicator(
        context: context, text: "Fetching date...");
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
    Navigator.pop(context);

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<PostProvider>(
        builder: (context, items, child) {
          return ListView.builder(
            itemBuilder: (_, index) {
              var post = items.posts[index];
              return postCard(post, context, items, index);
            },
            itemCount: items.posts.length,
          );
        },
      ),
    );
  }

  Card postCard(
      PostModel post, BuildContext context, PostProvider items, int index) {
    return Card(
      elevation: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  child: Icon(Icons.face_sharp),
                ),
                Flexible(
                  child: ListTile(
                    title: Text(post.username!),
                    subtitle: Text(getReadabelDate(post.createdAt!)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(post.context!),
              ],
            ),
          ),
          post.attachment != null && post.attachment!.endsWith("pdf")
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(items.posts[index].attachment!),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: SfPdfViewer.network(post.attachment!),
                      )
                    ],
                  ),
                )
              : SizedBox(),
          post.attachment != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.download),
                          label: Text("Download")),
                    ],
                  ),
                )
              : SizedBox(),
          Divider(),
          InkWell(
            onTap: () async {
              onTapShowComments(context, post).then((value) => {
                    if (value == true)
                      {
                        setState(() {
                          getCourseDetail(context);
                        })
                      }
                  });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                // alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(items.posts[index].commentSet!.length == 0
                        ? "Add Commnet"
                        : "${items.posts[index].commentSet!.length} Comments"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> onTapShowComments(BuildContext context, PostModel post) {
    return showModalBottomSheet<bool>(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 40,
                        ),
                        Text('Comments'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: Icon(Icons.send),
                            onPressed: () => {
                              if (comment != null)
                                {
                                  _postAPI
                                      .postComment(
                                          postID: post.id.toString(),
                                          comment: comment)
                                      .then((value) => {
                                            print(value),
                                            Navigator.pop(context, true)
                                          })
                                      .onError((error, stackTrace) => {
                                            print(error),
                                            Navigator.pop(context, false)
                                          })
                                      .catchError((onError) => {
                                            print(onError),
                                            Navigator.pop(context, false)
                                          })
                                }
                            },
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          comment = value;
                        },
                        decoration: kTextFiledDecoration.copyWith(
                            hintText: "Add Comment."),
                      ),
                    ),
                    commentListBuilder(post)
                  ],
                ),
              ));
        });
  }

  Widget commentListBuilder(PostModel post) {
    return SizedBox(
      height: 290,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var commentObj = post.commentSet![index]!;
          return Card(
            elevation: 10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        child: Icon(Icons.face_sharp),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(commentObj.username!),
                          subtitle:
                              Text(getReadabelDate(commentObj.createdAt!)),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 18,
                    ),
                    Text(commentObj.comment!),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
                // Text(post.commentSet![index]!.comment.toString()),
              ],
            ),
          );
        },
        itemCount: post.commentSet!.length,
      ),
    );
  }
}
