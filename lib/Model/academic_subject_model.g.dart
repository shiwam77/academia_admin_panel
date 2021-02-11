// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_subject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSubjectModel _$GetSubjectModelFromJson(Map<String, dynamic> json) {
  return GetSubjectModel(
    results: json['results'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AcademicSubjectModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    errorCode: json['errorCode'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$GetSubjectModelToJson(GetSubjectModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorCode': instance.errorCode,
      'status': instance.status,
      'results': instance.results,
      'data': instance.data,
    };

AcademicSubjectModel _$AcademicSubjectModelFromJson(Map<String, dynamic> json) {
  return AcademicSubjectModel(
    id: json['id'] as String,
    classId: json['classId'] as String,
    subjectName: json['subjectName'] as String,
  );
}

Map<String, dynamic> _$AcademicSubjectModelToJson(
        AcademicSubjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'classId': instance.classId,
      'subjectName': instance.subjectName,
    };
