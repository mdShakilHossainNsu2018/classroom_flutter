class LoginDataModel {
  String? token;
  int? userId;
  String? username;
  String? email;
  bool? isStaff;
  int? id;

  LoginDataModel(
      {this.token,
      this.userId,
      this.username,
      this.email,
      this.isStaff,
      this.id});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    isStaff = json['is_staff'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['is_staff'] = this.isStaff;
    data['id'] = this.id;
    return data;
  }
}
