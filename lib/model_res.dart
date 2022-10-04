// To parse this JSON data, do
//
//     final modelRes = modelResFromJson(jsonString);

import 'dart:convert';

List<ModelRes> modelResFromJson(String str) =>
    List<ModelRes>.from(json.decode(str).map((x) => ModelRes.fromJson(x)));

String modelResToJson(List<ModelRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelRes {
  ModelRes({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  int? userId;
  int? id;
  String? title;
  bool? completed;

  factory ModelRes.fromJson(Map<String, dynamic> json) => ModelRes(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
