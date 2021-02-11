// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_year_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAcademicYear _$GetAcademicYearFromJson(Map<String, dynamic> json) {
  return GetAcademicYear(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AcademicYearModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    results: json['results'] as int,
    message: json['message'] as String,
    errorCode: json['errorCode'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$GetAcademicYearToJson(GetAcademicYear instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorCode': instance.errorCode,
      'status': instance.status,
      'results': instance.results,
      'data': instance.data,
    };

AcademicYearModel _$AcademicYearModelFromJson(Map<String, dynamic> json) {
  return AcademicYearModel(
    year: json['year'] as int,
    id: json['id'] as String,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$AcademicYearModelToJson(AcademicYearModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'userId': instance.userId,
    };
