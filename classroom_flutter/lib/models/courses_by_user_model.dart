class CoursesByUserData {
  int? id;
  String? url;
  String? courseName;
  int? courseSection;
  String? courseCode;
  String? classDays;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  List<String>? users;

  CoursesByUserData(
      {this.id,
      this.url,
      this.courseName,
      this.courseSection,
      this.courseCode,
      this.classDays,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt,
      this.users});

  CoursesByUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    courseName = json['course_name'];
    courseSection = json['course_section'];
    courseCode = json['course_code'];
    classDays = json['class_days'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    users = json['users'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['course_name'] = this.courseName;
    data['course_section'] = this.courseSection;
    data['course_code'] = this.courseCode;
    data['class_days'] = this.classDays;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['users'] = this.users;
    return data;
  }
}
