// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class IgHomeTutor {
  IgHomeTutor({
    this.status,
    this.results,
    this.data,
  });

  String status;
  int results;
  List<HomeTutorModel> data;

  factory IgHomeTutor.fromJson(Map<String, dynamic> json) => IgHomeTutor(
    status: json["status"] == null ? null : json["status"],
    results: json["results"] == null ? null : json["results"],
    data: json["data"] == null ? null : List<HomeTutorModel>.from(json["data"].map((x) => HomeTutorModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "results": results == null ? null : results,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class HomeTutorModel {
  HomeTutorModel({
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
    this.classId
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
  String classId;

  factory HomeTutorModel.fromJson(Map<String, dynamic> json) => HomeTutorModel(
    subjectName: json["subjectName"] == null ? "" : json["subjectName"],
    teacherName: json["teacherName"] == null ? "" : json["teacherName"],
    description: json["description"] == null ? "" : json["description"],
    chapter: json["chapter"] == null ? "" : json["chapter"],
    file: json["file"] == null ? "" : json["file"],
    date: json["Date"] == null ? "" : json["Date"],
    id: json["id"],
    comment: json["comment"] == null ? "" : json["comment"],
    topic: json["topic"] == null ? "" : json["topic"],
    classId: json["classId"] == "" ? null : json["classId"],
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
    "classId": classId == null ? "" : classId,
  };
}
