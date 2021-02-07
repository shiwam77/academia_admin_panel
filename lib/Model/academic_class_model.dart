import 'package:academia_admin_panel/services/apiScheme.dart';
import 'package:json_annotation/json_annotation.dart';
part 'academic_class_model.g.dart';

@JsonSerializable()
class GetClassModel extends ApiSchema {

  final String status;
  final int results;
  final List<AcademicClassModel> data;
  GetClassModel({this.results,this.data,String message, String errorCode,this.status}):super(status,message,errorCode);
  factory GetClassModel.fromJson(Map<String, dynamic> json) => _$GetClassModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetClassModelToJson(this);
}

@JsonSerializable()
class AcademicClassModel{
  String id;
  String yearId;
  String className;
  AcademicClassModel({this.id,this.yearId,this.className});

  factory AcademicClassModel.fromJson(Map<String, dynamic> json) => _$AcademicClassModelFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicClassModelToJson(this);
}