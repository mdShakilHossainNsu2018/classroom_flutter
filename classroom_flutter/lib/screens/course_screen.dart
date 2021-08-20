import 'package:classroom_flutter/models/courses_by_user_model.dart';
import 'package:classroom_flutter/widgets/app_drawer.dart';
import 'package:classroom_flutter/widgets/attendance.dart';
import 'package:classroom_flutter/widgets/course_stream.dart';
import 'package:classroom_flutter/widgets/peoples.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  static const String routeName = "/course-screen";

  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
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
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CoursesByUserData;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(args.courseCode!),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Icon(
              Icons.video_call_outlined,
              size: 50,
            ),
          )
        ],
      ),
      body: _widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
