import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home-page";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Prefs.clearPref();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (route) => false);
            },
            icon: Icon(Icons.logout),
            label: Text("Logout"),
          )
        ],
      ),
      body: Container(),
    );
  }
}
