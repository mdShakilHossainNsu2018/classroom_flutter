import 'package:classroom_flutter/screens/home_screen.dart';
import 'package:classroom_flutter/screens/login_screen.dart';
import 'package:classroom_flutter/screens/registration_screen.dart';
import 'package:classroom_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegistrationScreen.routeName: (context) => RegistrationScreen(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
