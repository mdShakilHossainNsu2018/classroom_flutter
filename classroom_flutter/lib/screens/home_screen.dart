import 'dart:convert';

import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/controller/apis/course_api.dart';
import 'package:classroom_flutter/models/courses_by_user_model.dart';
import 'package:classroom_flutter/models/login_model.dart';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:classroom_flutter/screens/login_screen.dart';
import 'package:classroom_flutter/widgets/app_drawer.dart';
import 'package:classroom_flutter/widgets/course_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home-page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CourseApi _courseApi = CourseApi();

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  getCourses() async {
    LoginDataModel user = Prefs.getLoggedInUserDetails();
    var response = await _courseApi.getCourses(token: user.token!);
    if (response.statusCode == 200) {
      List<CoursesByUserData> _courseList = (jsonDecode(response.body) as List)
          .map((e) => CoursesByUserData.fromJson(e))
          .toList();

      Provider.of<Courses>(context, listen: false).setCourses(_courseList);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CoursesByUserData> _courseList = Provider.of<Courses>(context).courses;
    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ChatScreen.routeName);
        },
        child: Icon(Icons.chat_outlined),
      ),
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              logoutAndNavigate(context);
            },
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return CourseItem(index: index, courseList: _courseList);
            },
            itemCount: _courseList.length),
      ),
    );
  }

  void logoutAndNavigate(BuildContext context) {
    Prefs.clearPref();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, (route) => false);
  }
}
