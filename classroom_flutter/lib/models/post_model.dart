///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class PostModelCommentSet {
/*
{
  "id": 2,
  "username": "1812966642",
  "comment": "Comment",
  "created_at": "2021-08-10T04:46:45.910502Z",
  "updated_at": "2021-08-10T04:46:45.910555Z",
  "post": 7,
  "user": 2
}
*/

  int? id;
  String? username;
  String? comment;
  String? createdAt;
  String? updatedAt;
  int? post;
  int? user;

  PostModelCommentSet({
    this.id,
    this.username,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.post,
    this.user,
  });
  PostModelCommentSet.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    username = json["username"]?.toString();
    comment = json["comment"]?.toString();
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
    post = json["post"]?.toInt();
    user = json["user"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["username"] = username;
    data["comment"] = comment;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["post"] = post;
    data["user"] = user;
    return data;
  }
}

class PostModel {
/*
{
  "id": 7,
  "username": "1812966642",
  "email": "shakil.hossain3@northsouth.edu",
  "comment_set": [
    {
      "id": 2,
      "username": "1812966642",
      "comment": "Comment",
      "created_at": "2021-08-10T04:46:45.910502Z",
      "updated_at": "2021-08-10T04:46:45.910555Z",
      "post": 7,
      "user": 2
    }
  ],
  "context": "# new post",
  "attachment": null,
  "due_date": null,
  "due_time": null,
  "type": "post",
  "created_at": "2021-08-10T04:46:34.983801Z",
  "updated_at": "2021-08-10T04:46:34.983827Z",
  "user": 2,
  "course": 1
}
*/

  int? id;
  String? username;
  String? email;
  List<PostModelCommentSet?>? commentSet;
  String? context;
  String? attachment;
  String? dueDate;
  String? dueTime;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? user;
  int? course;

  PostModel({
    this.id,
    this.username,
    this.email,
    this.commentSet,
    this.context,
    this.attachment,
    this.dueDate,
    this.dueTime,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.course,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    username = json["username"]?.toString();
    email = json["email"]?.toString();
    if (json["comment_set"] != null) {
      final v = json["comment_set"];
      final arr0 = <PostModelCommentSet>[];
      v.forEach((v) {
        arr0.add(PostModelCommentSet.fromJson(v));
      });
      commentSet = arr0;
    }
    context = json["context"]?.toString();
    attachment = json["attachment"]?.toString();
    dueDate = json["due_date"]?.toString();
    dueTime = json["due_time"]?.toString();
    type = json["type"]?.toString();
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
    user = json["user"]?.toInt();
    course = json["course"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["username"] = username;
    data["email"] = email;
    if (commentSet != null) {
      final v = commentSet;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["comment_set"] = arr0;
    }
    data["context"] = context;
    data["attachment"] = attachment;
    data["due_date"] = dueDate;
    data["due_time"] = dueTime;
    data["type"] = type;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["user"] = user;
    data["course"] = course;
    return data;
  }
}