import 'dart:convert';

import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/constants/constants.dart';
import 'package:classroom_flutter/controller/apis/api_error.dart';
import 'package:classroom_flutter/controller/apis/user_api.dart';
import 'package:classroom_flutter/controller/user_controller.dart';
import 'package:classroom_flutter/models/login_model.dart';
import 'package:classroom_flutter/screens/registration_screen.dart';
import 'package:classroom_flutter/snippets/loading_indicator.dart';
import 'package:classroom_flutter/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _username;
  late String _password;
  bool _isLoading = false;
  bool _isObscureText = true;
  final LoadingIndicator _loadingIndicator = LoadingIndicator();
  final ApiError _apiError = ApiError();
  final UserController _userController = UserController();
  final UserApi _userApi = UserApi();

  @override
  void initState() {
    super.initState();
    Prefs.loadPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // todo: add loading indicator.
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                _username = value;
              },
              decoration: kTextFiledDecoration.copyWith(
                  hintText: "Enter Your username.",
                  suffixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.lightBlueAccent,
                  )),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                _password = value;
              },
              textAlign: TextAlign.center,
              obscureText: _isObscureText,
              decoration: kTextFiledDecoration.copyWith(
                  hintText: 'Enter your password.',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscureText = !_isObscureText;
                        });
                      },
                      icon: Icon(
                        _isObscureText
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        color: Colors.lightBlueAccent,
                      ))),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: 'Log In',
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                _loadingIndicator.showLoadingIndicator(
                    context: context, text: "Logging...");
                // todo sign in request
                //await UserApi().login(username: _username, password: _password);

                var response = await _userApi.login(
                    username: _username, password: _password);

                if (response.statusCode == 200) {
                  LoginDataModel user =
                      LoginDataModel.fromJson(jsonDecode(response.body));
                  Prefs.setLoggedInUser(user);
                  getUserAndNavigate();
                } else {
                  Prefs.clearPref();
                  _apiError.showError("Something wrong! try again", context);
                }

                setState(() {
                  _isLoading = false;
                });

                // _userController
                //     .signInWithEmailAndPassword(
                //         context: context, email: _email, password: _password)
                //     .then((value) => getUserAndNavigate())
                //     .catchError((error) => _apiError.showError(error, context));
              },
            ),
            TextButton(
              child: Text("Create account."),
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  void getUserAndNavigate() {
    Navigator.pop(context);
    // todo navigate to the main screen.

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
    // Navigator.popAndPushNamed(context, PeopleScreen.routeName);
  }
}
