// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class IgHomeTask {
  IgHomeTask({
    this.status,
    this.results,
    this.data,
  });

  String status;
  int results;
  List<HomeTaskModel> data;

  factory IgHomeTask.fromJson(Map<String, dynamic> json) => IgHomeTask(
    status: json["status"] == null ? null : json["status"],
    results: json["results"] == null ? null : json["results"],
    data: json["data"] == null ? null : List<HomeTaskModel>.from(json["data"].map((x) => HomeTaskModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "results": results == null ? null : results,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class HomeTaskModel {
  HomeTaskModel({
    this.createdAt,
    this.id,
    this.subjectName,
    this.teacherName,
    this.description,
    this.chapter,
    this.file,
    this.date,
    this.datumId,
    this.comment,
    this.topic,
    this.subjectId
  });

  DateTime createdAt = DateTime.now();
  String id;
  String subjectName;
  String teacherName;
  String description;
  String chapter;
  String file;
  String date;
  String datumId;
  String comment;
  String topic;
  String subjectId;

  factory HomeTaskModel.fromJson(Map<String, dynamic> json) => HomeTaskModel(
    subjectName: json["subjectName"] == null ? null : json["subjectName"],
    teacherName: json["teacherName"] == null ? null : json["teacherName"],
    description: json["description"] == null ? null : json["description"],
    chapter: json["chapter"] == null ? null : json["chapter"],
    file: json["file"] == null ? null : json["file"],
    date: json["Date"] == null ? null : json["Date"],
    id: json["id"],
    comment: json["comment"] == null ? null : json["comment"],
    topic: json["topic"] == null ? null : json["topic"],
    subjectId: json["subjectId"] == null ? null : json["subjectId"],
  );

  Map<String, dynamic> toJson() => {
    "subjectName": subjectName == null ? null : subjectName,
    "teacherName": teacherName == null ? null : teacherName,
    "description": description == null ? null : description,
    "chapter": chapter == null ? null : chapter,
    "file": file == null ? null : file,
    "Date": date == null ? null : date,
    "id": id,
    "comment": comment == null ? null : comment,
    "topic": topic == null ? null : topic,
    "subjectId": subjectId == null ? null : subjectId,
  };
}
