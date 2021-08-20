import 'dart:io';

import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/models/courses_by_user_model.dart';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:classroom_flutter/screens/chat_screen.dart';
import 'package:classroom_flutter/screens/course_screen.dart';
import 'package:classroom_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CoursesByUserData> _courseList = Provider.of<Courses>(context).courses;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'ClassRoom',
                    style: TextStyle(
                      color: Colors.red.shade500,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' app',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              "Enrolled",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: 70.0 * _courseList.length.toDouble(),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  leading: CircleAvatar(
                    child: Text(
                      _courseList[index].courseCode![0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  title: Text(_courseList[index].courseCode!),
                  onTap: () {
                    Navigator.popAndPushNamed(context, CourseScreen.routeName,
                        arguments: _courseList[index]);
                  },
                );
              },
              itemCount: _courseList.length,
            ),
          ),

          // Divider(),

          Divider(),

          ListTile(
            title: const Text('Chat BOT'),
            leading: Icon(Icons.chat_outlined),
            onTap: () {
              Navigator.pushNamed(context, ChatScreen.routeName);
            },
          ),

          ListTile(
            title: const Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              logoutAndNavigate(context);
            },
          ),

          ListTile(
            title: const Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }

  void logoutAndNavigate(BuildContext context) {
    Prefs.clearPref();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, (route) => false);
  }
}
