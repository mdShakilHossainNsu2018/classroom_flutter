import 'package:classroom_flutter/models/courses_by_user_model.dart';
import 'package:flutter/material.dart';

class Courses with ChangeNotifier {
  List<CoursesByUserData> _courses = [];

  List<CoursesByUserData> get courses {
    return [..._courses];
  }

  void setCourses(List<CoursesByUserData> courses) {
    _courses = courses;
    notifyListeners();
  }
}
