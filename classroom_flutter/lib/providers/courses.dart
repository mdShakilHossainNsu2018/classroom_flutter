import 'package:classroom_flutter/models/courses_by_user_model.dart';
import 'package:flutter/material.dart';

class Courses with ChangeNotifier {
  List<CourseInfoModel> _courses = [];
  CourseInfoModel? _currentCourse;

  void setCurrentCourse(CourseInfoModel course) {
    _currentCourse = course;
    notifyListeners();
  }

  CourseInfoModel? get currentCourse {
    return _currentCourse;
  }

  List<CourseInfoModel> get courses {
    return [..._courses];
  }

  void setCourses(List<CourseInfoModel> courses) {
    _courses = courses;
    notifyListeners();
  }
}
