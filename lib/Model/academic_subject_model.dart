import 'package:academia_admin_panel/services/apiScheme.dart';
import 'package:json_annotation/json_annotation.dart';
part 'academic_subject_model.g.dart';

@JsonSerializable()
class GetSubjectModel extends ApiSchema {

  final String status;
  final int results;
  final List<AcademicSubjectModel> data;
  GetSubjectModel({this.results,this.data,String message, String errorCode,this.status}):super(status,message,errorCode);
  factory GetSubjectModel.fromJson(Map<String, dynamic> json) => _$GetSubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetSubjectModelToJson(this);
}

@JsonSerializable()
class AcademicSubjectModel{
  String id;
  String classId;
  String subjectName;
  AcademicSubjectModel({this.id,this.classId,this.subjectName});

  factory AcademicSubjectModel.fromJson(Map<String, dynamic> json) => _$AcademicSubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicSubjectModelToJson(this);
}