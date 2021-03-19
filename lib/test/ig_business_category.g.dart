// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ig_business_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IgBusinessCategory _$IgBusinessCategoryFromJson(Map<String, dynamic> json) {
  return IgBusinessCategory(
    json['status'] as String,
    json['msg'] as String,
    json['error_code'] as String,
    json['error_data'] as Map<String, dynamic>,
    json['data'] == null
        ? null
        : IgBusinessDetails.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IgBusinessCategoryToJson(IgBusinessCategory instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'error_code': instance.error_code,
      'error_data': instance.error_data,
      'data': instance.data,
    };

IgBusinessDetails _$IgBusinessDetailsFromJson(Map<String, dynamic> json) {
  return IgBusinessDetails(
    id: json['id'] as String,
    age_groups: json['age_groups'] as String,
    category: json['category'] as String,
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    target_female: json['target_female'] as bool,
    target_male: json['target_male'] as bool,
    updated_at: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$IgBusinessDetailsToJson(IgBusinessDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'target_male': instance.target_male,
      'target_female': instance.target_female,
      'age_groups': instance.age_groups,
      'category': instance.category,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
