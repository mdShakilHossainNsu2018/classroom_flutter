import 'dart:convert';
import 'package:classroom_flutter/Share_preference/Share_pref.dart';
import 'package:classroom_flutter/controller/apis/attendance_user.dart';
import 'package:classroom_flutter/controller/apis/user_api.dart';
import 'package:classroom_flutter/models/api_attendance_model.dart';
import 'package:classroom_flutter/models/attendance_model.dart';
import 'package:classroom_flutter/models/enrolled_user_model.dart';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:classroom_flutter/screens/home_screen.dart';
import 'package:classroom_flutter/snippets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  UserApi _userApi = UserApi();
  AttendanceAPI _attendanceAPI = AttendanceAPI();

  bool test = false;

  List<AttendanceModel> createAttendance = [];
  List<ApiAttendanceModel> _attendance = [];

  List<EnrolledUserModel> _listEnrolledUser = [];
  LoadingIndicator _loadingIndicator = LoadingIndicator();

  @override
  void initState() {
    super.initState();

    new Future.delayed(Duration.zero, () {
      if (Prefs.getLoggedInUserDetails().isStaff!) {
        getPeoples(context);
      } else {
        fetchAttendance(context);
      }
    });
  }

  fetchAttendance(BuildContext context) async {
    _loadingIndicator.showLoadingIndicator(
        context: context, text: "Fetching Data");
    var id = context.read<Courses>().currentCourse!.id;

    var response = await _attendanceAPI.getAttendace(courseId: id.toString());

    if (response.statusCode == 200) {
      setState(() {
        _attendance = (jsonDecode(response.body) as List)
            .map((e) => ApiAttendanceModel.fromJson(e))
            .toList();
      });
      // print(response.body);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
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
            .where((element) => !element.isStaff! && !element.isSuperuser!)
            .toList();
        _listEnrolledUser.forEach((element) {
          var item = AttendanceModel(
              user: element.id.toString(),
              is_attend: false,
              course: id.toString());
          createAttendance.add(item);
        });
      });

      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Prefs.getLoggedInUserDetails().isStaff!
        ? Column(
            children: [
              SizedBox(
                height: 520,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 10,
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.account_circle),
                            Text(_listEnrolledUser[index]
                                .username!
                                .toUpperCase()),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Icon(Icons.email),
                            Flexible(
                                child: Text(_listEnrolledUser[index].email!)),
                          ],
                        ),
                        trailing: Switch(
                          onChanged: (value) => {
                            // print(value)
                            setState(() {
                              //   // test = value;
                              //   print(createAttendance[index].is_attend);

                              createAttendance[index].is_attend = value;
                              // print(_listEnrolledUser[index].email);
                            })
                          },
                          value: createAttendance[index].is_attend,
                        ),
                      ),
                    );
                  },
                  itemCount: _listEnrolledUser.length,
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  _loadingIndicator.showLoadingIndicator(
                      context: context, text: "Submitting attendance");
                  _attendanceAPI
                      .postAttendance(attendanceList: createAttendance)
                      .then((value) => {
                            print(value.body),
                            Navigator.pop(context),
                            Navigator.pushNamed(context, HomePage.routeName)
                          })
                      .catchError((err) => {
                            print(
                              err.toString(),
                            )
                          })
                      .onError((error, stackTrace) => {Navigator.pop(context)});
                },
                label: Text("Submit Attendance"),
              )
            ],
          )
        : AttendanceTable(_attendance);
  }
}

class AttendanceTable extends StatefulWidget {
  AttendanceTable(this.attendance);
  final List<ApiAttendanceModel> attendance;

  @override
  State<AttendanceTable> createState() => _AttendanceTableState();
}

class _AttendanceTableState extends State<AttendanceTable> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text('#'),
            ),
            DataColumn(
              label: Text('Date'),
            ),
            DataColumn(
              label: Text('Attendance'),
            ),
          ],
          rows: List<DataRow>.generate(
              widget.attendance.length,
              (int index) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // All rows will have the same selected color.
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      }
                      // Even rows will have a grey color.
                      if (index.isEven) {
                        return Colors.grey.withOpacity(0.3);
                      }
                      return null; // Use default value for other states and odd rows.
                    }),
                    cells: <DataCell>[
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(
                          '${DateFormat.yMMMMd().format(DateTime.parse(widget.attendance[index].createdAt!))}')),
                      DataCell(Text(
                          '${widget.attendance[index].isAttend! ? "Yes" : "No"}')),
                    ],
                  ))),
    );
  }
}
