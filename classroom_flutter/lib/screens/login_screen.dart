import 'package:classroom_flutter/constants/constants.dart';
import 'package:classroom_flutter/snippets/loading_indicator.dart';
import 'package:classroom_flutter/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email;
  String? _password;
  bool _isLoading = false;
  bool _isObscureText = true;

  final LoadingIndicator _loadingIndicator = LoadingIndicator();

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
                _email = value;
              },
              decoration: kTextFiledDecoration.copyWith(
                  hintText: "Enter Your Email.",
                  suffixIcon: Icon(
                    Icons.email,
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
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                _loadingIndicator.showLoadingIndicator(
                    context: context, text: "Logging...");
                // todo sign in request
                // _userController
                //     .signInWithEmailAndPassword(
                //         context: context, email: _email, password: _password)
                //     .then((value) => getUserAndNavigate())
                //     .catchError((error) => _apiError.showError(error, context));
                setState(() {
                  _isLoading = false;
                });
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
    // Navigator.popAndPushNamed(context, PeopleScreen.routeName);
  }
}
