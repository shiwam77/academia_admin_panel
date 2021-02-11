// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetClassModel _$GetClassModelFromJson(Map<String, dynamic> json) {
  return GetClassModel(
    results: json['results'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AcademicClassModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    errorCode: json['errorCode'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$GetClassModelToJson(GetClassModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorCode': instance.errorCode,
      'status': instance.status,
      'results': instance.results,
      'data': instance.data,
    };

AcademicClassModel _$AcademicClassModelFromJson(Map<String, dynamic> json) {
  return AcademicClassModel(
    id: json['id'] as String,
    yearId: json['yearId'] as String,
    className: json['className'] as String,
  );
}

Map<String, dynamic> _$AcademicClassModelToJson(AcademicClassModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'yearId': instance.yearId,
      'className': instance.className,
    };
