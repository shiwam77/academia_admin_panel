// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema_pojo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return ApiResponse(
    json['status'] as String,
    json['message'] as String,
    json['errorCode'] as String,
  );
}

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errorCode': instance.errorCode,
    };
