import 'package:classroom_flutter/constants/constants.dart';
import 'package:classroom_flutter/models/courses_by_user_model.dart';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:classroom_flutter/screens/course_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({
    Key? key,
    required int index,
    required List<CourseInfoModel> courseList,
  })  : _courseList = courseList,
        index = index,
        super(key: key);

  final List<CourseInfoModel> _courseList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Courses>(context, listen: false)
            .setCurrentCourse(_courseList[index]);
        Navigator.pushNamed(context, CourseScreen.routeName);
      },
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            // Text("course"),
            ListTile(
              // contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.class__outlined,
                color: Colors.lightBlueAccent,
              ),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: _courseList[index].courseName,
                      style: TextStyle(
                        color: Colors.red.shade500,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: " (${_courseList[index].courseCode})",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              title: Text(
                "Section: ${_courseList[index].courseSection}",
                style: KCourseContentTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                "Days: ${_courseList[index].classDays!.toUpperCase()}",
                style: KCourseContentTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                "${_courseList[index].startTime!} - ${_courseList[index].endTime}",
                style: KCourseContentTextStyle,
              ),
              leading: Icon(
                Icons.access_time,
                color: Colors.lightBlueAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
