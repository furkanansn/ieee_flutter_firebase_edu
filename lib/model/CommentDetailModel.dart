// To parse this JSON data, do
//
//     final commentDetail = commentDetailFromJson(jsonString);

import 'dart:convert';

CommentDetail commentDetailFromJson(String str) => CommentDetail.fromJson(json.decode(str));

String commentDetailToJson(CommentDetail data) => json.encode(data.toJson());

class CommentDetail {
  CommentDetail({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory CommentDetail.fromJson(Map<String, dynamic> json) => CommentDetail(
    userId: json["userId"] == null ? null : json["userId"],
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId == null ? null : userId,
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "body": body == null ? null : body,
  };
}
