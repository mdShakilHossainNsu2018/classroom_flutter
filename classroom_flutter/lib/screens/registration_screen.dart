import 'package:classroom_flutter/constants/constants.dart';
import 'package:classroom_flutter/snippets/loading_indicator.dart';
import 'package:classroom_flutter/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String? password;

  bool _isLoading = false;
  bool _isObscureText = true;

  final LoadingIndicator _loadingIndicator = LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
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
            TextField(
              textAlign: TextAlign.center,
              obscureText: _isObscureText,
              onChanged: (value) {
                password = value;
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
              height: 24.0,
            ),
            RoundedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                _loadingIndicator.showLoadingIndicator(
                    context: context, text: "Loading...");
                // todo: sign up request will call here

                // _userController
                //     .createUserWithEmailAndPassword(
                //         context: context, email: email, password: password)
                //     .then((value) => _onSuccessfullyRegister())
                //     .catchError(
                //         (error) => _apiError.showError(error, context));
                setState(() {
                  _isLoading = false;
                });
              },
              text: 'Register',
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

  void _onSuccessfullyRegister() {
    // print(FirebaseAuth.instance.currentUser.email);
    // _userController
    //     .createUserInfo(imageUrl: null)
    //     .then((value) => _onSuccessCreateUserInfo())
    //     .catchError((error) => _apiError.showError(error, context));
  }

  void _onSuccessCreateUserInfo() {
    Navigator.pop(context);
    // todo: logic after successfully sign up.
    // Navigator.popAndPushNamed(context, PeopleScreen.routeName);
  }
}
