import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/services/apiScheme.dart';
import 'package:json_annotation/json_annotation.dart';
part 'academic_year_model.g.dart';

@JsonSerializable()
class GetAcademicYear extends ApiSchema{
  final String status;
  final int results;
  final List<AcademicYearModel> data;
  GetAcademicYear({this.data,this.results,String message, String errorCode,this.status}):super(status,message,errorCode);

  factory GetAcademicYear.fromJson(Map<String, dynamic> json) => _$GetAcademicYearFromJson(json);

  Map<String, dynamic> toJson() => _$GetAcademicYearToJson(this);
}

@JsonSerializable()
class AcademicYearModel{
   String id;
  final int year;
  final String userId;
  AcademicYearModel({this.year,this.id,this.userId});

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) => _$AcademicYearModelFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicYearModelToJson(this);
}
