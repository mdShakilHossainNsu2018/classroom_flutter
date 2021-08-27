import 'dart:convert';
import 'dart:developer';

import 'package:classroom_flutter/controller/apis/user_api.dart';
import 'package:classroom_flutter/models/enrolled_user_model.dart';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:classroom_flutter/snippets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class Peoples extends StatefulWidget {
  const Peoples({Key? key}) : super(key: key);

  @override
  _PeoplesState createState() => _PeoplesState();
}

class _PeoplesState extends State<Peoples> {
  UserApi _userApi = UserApi();

  List<EnrolledUserModel> _listEnrolledUser = [];
  LoadingIndicator _loadingIndicator = LoadingIndicator();

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      getPeoples(context);
    });
  }

  getPeoples(BuildContext context) async {
    _loadingIndicator.showLoadingIndicator(
        context: context, text: "Fetching Data");
    var id = context.read<Courses>().currentCourse!.id;

    var response = await _userApi.getUsersByCourse(courseId: id.toString());

    if (response.statusCode == 200) {
      setState(() {
        _listEnrolledUser = (jsonDecode(response.body) as List)
            .map((e) => EnrolledUserModel.fromJson(e))
            .toList();
      });
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          child: ListTile(
            title: Row(
              children: [
                Icon(Icons.account_circle),
                Text(_listEnrolledUser[index].username!.toUpperCase()),
              ],
            ),
            subtitle: Row(
              children: [
                Icon(Icons.email),
                Flexible(child: Text(_listEnrolledUser[index].email!)),
              ],
            ),
            trailing: _listEnrolledUser[index].isStaff!
                ? Text("Teacher")
                : Text("Student"),
          ),
        );
      },
      itemCount: _listEnrolledUser.length,
    );
  }
}
