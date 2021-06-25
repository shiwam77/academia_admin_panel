import 'package:academia_admin_panel/Model/academic_student_model.dart';
import 'package:academia_admin_panel/services/apiScheme.dart';
import 'package:json_annotation/json_annotation.dart';
part 'academic_attendance_model.g.dart';

@JsonSerializable()
class GetAttendanceModel extends ApiSchema {

  final String status;
  final int results;
  final List<GetAttendance> data;
  GetAttendanceModel({this.results,this.data,String message, String errorCode,this.status}):super(status,message,errorCode);
  factory GetAttendanceModel.fromJson(Map<String, dynamic> json) => _$GetAttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAttendanceModelToJson(this);
}

@JsonSerializable()
class GetAttendance{

  final String studentId;
  List<bool> attendance;
  AcademicStudentModel Student;
  GetAttendance(this.attendance,this.Student,this.studentId);
  factory GetAttendance.fromJson(Map<String, dynamic> json) => _$GetAttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$GetAttendanceToJson(this);
}

