// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAttendanceModel _$GetAttendanceModelFromJson(Map<String, dynamic> json) {
  return GetAttendanceModel(
    results: json['results'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GetAttendance.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    errorCode: json['errorCode'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$GetAttendanceModelToJson(GetAttendanceModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorCode': instance.errorCode,
      'status': instance.status,
      'results': instance.results,
      'data': instance.data,
    };

GetAttendance _$GetAttendanceFromJson(Map<String, dynamic> json) {
  return GetAttendance(
    (json['attendance'] as List)?.map((e) => e as bool)?.toList(),
    json['Student'] == null
        ? null
        : AcademicStudentModel.fromJson(
            json['Student'] as Map<String, dynamic>),
    json['studentId'] as String,
  );
}

Map<String, dynamic> _$GetAttendanceToJson(GetAttendance instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'attendance': instance.attendance,
      'Student': instance.Student,
    };
