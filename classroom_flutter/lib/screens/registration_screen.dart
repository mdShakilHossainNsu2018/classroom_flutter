import 'dart:convert';

import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/constants/constants.dart';
import 'package:classroom_flutter/controller/apis/user_api.dart';
import 'package:classroom_flutter/models/login_model.dart';
import 'package:classroom_flutter/snippets/loading_indicator.dart';
import 'package:classroom_flutter/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = "/registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _username;
  late String _email;
  late String _password1;
  late String _password2;

  // is_staff: false,

  bool _isLoading = false;
  bool _isObscureText = true;

  final LoadingIndicator _loadingIndicator = LoadingIndicator();
  final UserApi _userApi = UserApi();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                isKeyBoard
                    ? SizedBox(
                        height: 8,
                      )
                    : Hero(
                        tag: 'logo',
                        child: Container(
                          height: 200.0,
                          child: Image.asset('images/logo.png'),
                        ),
                      ),
                SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          _username = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                        decoration: kTextFiledDecoration.copyWith(
                          hintText: 'Enter your username',
                          suffixIcon: Icon(
                            Icons.perm_identity,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _email = value;
                        },
                        decoration: kTextFiledDecoration.copyWith(
                          hintText: 'Enter your email',
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: _isObscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Empty password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _password1 = value;
                        },
                        decoration: kTextFiledDecoration.copyWith(
                          hintText: 'Enter your password',
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
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: _isObscureText,
                        onChanged: (value) {
                          _password2 = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Empty confirm password.';
                          }

                          if (value != _password1) {
                            return "Password mismatch";
                          }
                          return null;
                        },
                        decoration: kTextFiledDecoration.copyWith(
                          hintText: 'Confirm password',
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      _loadingIndicator.showLoadingIndicator(
                          context: context, text: "Loading...");

                      var response = await _userApi.signup(
                          username: _username,
                          password: _password1,
                          email: _email);
                      if (response.statusCode == 201) {
                        var loginResponse = await _userApi.login(
                            username: _username, password: _password1);

                        if (loginResponse.statusCode == 200) {
                          LoginDataModel user = LoginDataModel.fromJson(
                              jsonDecode(loginResponse.body));
                          Prefs.setLoggedInUser(user);
                          _onSuccessCreateUserAndLogin();
                        } else {
                          Prefs.clearPref();
                          _onError(context, loginResponse);
                        }
                      } else {
                        _onError(context, response);
                      }
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  text: 'Register',
                  color: Colors.blueAccent,
                ),
                TextButton(
                  child: Text("already have and account."),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onError(BuildContext context, Response response) {
    Navigator.pop(context);

    // Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "${response.body} errorCode: ${response.statusCode}",
        style: TextStyle(color: Colors.red),
      ),
    ));
  }

  void _onSuccessfullyRegister() {
    // print(FirebaseAuth.instance.currentUser.email);
    // _userController
    //     .createUserInfo(imageUrl: null)
    //     .then((value) => _onSuccessCreateUserInfo())
    //     .catchError((error) => _apiError.showError(error, context));
  }

  void _onSuccessCreateUserAndLogin() {
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
        context, HomePage.routeName, (route) => false);
  }
}
