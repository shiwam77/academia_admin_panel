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
    subjectName: json["subjectName"] == null ? "" : json["subjectName"],
    teacherName: json["teacherName"] == null ? "" : json["teacherName"],
    description: json["description"] == null ? "" : json["description"],
    chapter: json["chapter"] == null ? "" : json["chapter"],
    file: json["file"] == null ? "" : json["file"],
    date: json["Date"] == null ? "" : json["Date"],
    id: json["id"],
    comment: json["comment"] == null ? "" : json["comment"],
    topic: json["topic"] == null ? "" : json["topic"],
    subjectId: json["subjectId"] == "" ? null : json["subjectId"],
  );

  Map<String, dynamic> toJson() => {
    "subjectName": subjectName == null ? "" : subjectName,
    "teacherName": teacherName == null ? "" : teacherName,
    "description": description == null ? "" : description,
    "chapter": chapter == null ? "" : chapter,
    "file": file == null ? "" : file,
    "Date": date == null ? "" : date,
    "id": id,
    "comment": comment == null ? "" : comment,
    "topic": topic == null ? "" : topic,
    "subjectId": subjectId == null ? "" : subjectId,
  };
}
