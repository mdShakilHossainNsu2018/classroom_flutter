import 'dart:io';
import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/constants/api_constant.dart';
import 'package:classroom_flutter/controller/apis/post_api.dart';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/src/provider.dart';
import 'package:path/path.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePostScreen> {
  String dropdownValue = "Post";
  DateTime? dueOn;
  File? file;
  String content = "";

  PostAPI _postAPI = PostAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        actions: [
          TextButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  setState(() {
                    file = File(result.files.single.path!);
                  });

                  print(file);
                } else {
                  // User canceled the picker
                }
              },
              child: Icon(
                Icons.attach_file,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String courseId =
              context.read<Courses>().currentCourse!.id.toString();
          _postAPI
              .createPost(
                  courseId: courseId,
                  context: content,
                  file: file,
                  dateTime: dueOn,
                  type: dropdownValue)
              .then((response) =>
                  {print(response.statusCode), Navigator.pop(context, 201)})
              .catchError((onError) => {print(onError)})
              .onError((error, stackTrace) => {})
              .whenComplete(() => {});
        },
        child: Icon(Icons.send),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.grey[350],
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 8,
                decoration:
                    InputDecoration.collapsed(hintText: "Enter your text here"),
                onChanged: (value) {
                  content = value;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Type: "),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;

                      if (dropdownValue == "Assignment") {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            dueOn = date;
                          });

                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      }
                    });
                  },
                  items: <String>['Post', 'Assignment']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          dueOn != null
              ? ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: Icon(Icons.lock_clock),
                  title: Text("${dueOn} "),
                )
              : SizedBox(),
          file != null
              ? ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: Icon(Icons.attach_file),
                  title: Text("${basename(file!.path.toString())} "),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
