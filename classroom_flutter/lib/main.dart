import 'dart:core';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:classroom_flutter/providers/posts.dart';
import 'package:classroom_flutter/providers/theam.dart';
import 'package:classroom_flutter/screens/call_screen.dart';
import 'package:classroom_flutter/screens/chat_screen.dart';
import 'package:classroom_flutter/screens/course_screen.dart';
import 'package:classroom_flutter/screens/home_screen.dart';
import 'package:classroom_flutter/screens/login_screen.dart';
import 'package:classroom_flutter/screens/registration_screen.dart';
import 'package:classroom_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Courses>(create: (context) => Courses()),
        ChangeNotifierProvider<PostProvider>(
            create: (context) => PostProvider()),
        ChangeNotifierProvider<TheamProvider>(
            create: (context) => TheamProvider()),
      ],
      child: Consumer<TheamProvider>(builder: (context, theam, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theam.getTheme(),
          initialRoute: SplashPage.routeName,
          routes: {
            SplashPage.routeName: (context) => SplashPage(),
            LoginScreen.routeName: (context) => LoginScreen(),
            RegistrationScreen.routeName: (context) => RegistrationScreen(),
            HomePage.routeName: (context) => HomePage(),
            CourseScreen.routeName: (context) => CourseScreen(),
            ChatScreen.routeName: (context) => ChatScreen(),
            CallScreen.routeName: (context) => CallScreen(),
          },
        );
      }),
    );
  }
}
