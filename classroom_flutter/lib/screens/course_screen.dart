import 'package:classroom_flutter/models/courses_by_user_model.dart';
import 'package:classroom_flutter/providers/courses.dart';
import 'package:classroom_flutter/screens/call_screen.dart';
import 'package:classroom_flutter/screens/create_post_screen.dart';
import 'package:classroom_flutter/widgets/app_drawer.dart';
import 'package:classroom_flutter/widgets/attendance.dart';
import 'package:classroom_flutter/widgets/course_stream.dart';
import 'package:classroom_flutter/widgets/peoples.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  static const String routeName = "/course-screen";

  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  // CourseApi _courseApi = CourseApi();

  CourseInfoModel? _currentCourse;

  List<Widget> _widgets = [
    CourseStream(),
    Attendance(),
    Peoples(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // _currentCourse = context.read<Courses>().currentCourse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Consumer<Courses>(builder: (context, course, child) {
          return Text(course.currentCourse!.courseCode!);
        }),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, CallScreen.routeName);
            },
            child: Icon(
              Icons.video_call_outlined,
              size: 40,
  
              color: Colors.white,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const CreatePostScreen(),
            ),
          ) as int;

          setState(() {
            if (value == 201) {
              print(value);
              // _selectedIndex = 1;
              // _selectedIndex = 1;
              CourseStreamState().getCourseDetail(context);

              // CourseStream().createState().initState();
              // initState();
            }
          });
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: _widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        key: UniqueKey(),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.view_stream_rounded),
            label: 'Stream',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'People',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
