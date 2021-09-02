class AttendanceModel {
  // course: this.id,
  // user: obj.id,
  // s_attend: true,

  final String course;
  final String user;
  bool is_attend;

  AttendanceModel(
      {required this.course, required this.user, required this.is_attend});

       Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["is_attend"] = is_attend;
    data["course"] = course;
    data["user"] = user;
    return data;
  }
}
