import 'dart:async';

import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/constants/theam.dart';
import 'package:classroom_flutter/providers/theam.dart';
import 'package:classroom_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(Duration(seconds: 3), () {
      setPref();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => LoginScreen()),
    //     (route) => false);
  }

  void setPref() async {
    await Prefs.loadPref();
    if (Prefs.getBool(Prefs.IS_LOGGED_IN, def: false) != null &&
        Prefs.getBool(Prefs.IS_LOGGED_IN, def: false) == true) {
      if (Prefs.getLoggedInUserDetails().isStaff == true) {
        Provider.of<TheamProvider>(context, listen: false).setTheme(darkTheme);
      }

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'ClassRoom',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'app',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              height: 2,
              child: LinearProgressIndicator(
                backgroundColor: Colors.blue,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
