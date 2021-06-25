// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ig_user_initiated_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IgUserInitiatedInfo _$IgUserInitiatedInfoFromJson(Map<String, dynamic> json) {
  return IgUserInitiatedInfo(
    json['status'] as String,
    json['msg'] as String,
    json['error_code'] as String,
    json['error_data'] as Map<String, dynamic>,
    json['data'] == null
        ? null
        : IgUser.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IgUserInitiatedInfoToJson(
        IgUserInitiatedInfo instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'error_code': instance.error_code,
      'error_data': instance.error_data,
      'data': instance.data,
    };

IgUser _$IgUserFromJson(Map<String, dynamic> json) {
  return IgUser(
    user_name: json['user_name'] as String,
    profile_type: json['profile_type'] as String,
    is_deleted: json['is_deleted'] as bool,
    is_active: json['is_active'] as bool,
    email: json['email'] as String,
    creator_details: json['creator_details'] == null
        ? null
        : IgCreatorDetails.fromJson(
            json['creator_details'] as Map<String, dynamic>),
    contact_no: json['contact_no'] as String,
    business_details: json['business_details'] == null
        ? null
        : IgBusinessDetails.fromJson(
            json['business_details'] as Map<String, dynamic>),
    updated_at: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    uuid: json['uuid'] as String,
  );
}

Map<String, dynamic> _$IgUserToJson(IgUser instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'user_name': instance.user_name,
      'email': instance.email,
      'contact_no': instance.contact_no,
      'profile_type': instance.profile_type,
      'is_active': instance.is_active,
      'is_deleted': instance.is_deleted,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'creator_details': instance.creator_details,
      'business_details': instance.business_details,
    };

IgBusinessDetails _$IgBusinessDetailsFromJson(Map<String, dynamic> json) {
  return IgBusinessDetails(
    id: json['id'] as String,
    age_groups: (json['age_groups'] as List)?.map((e) => e as String)?.toList(),
    category: json['category'] as String,
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    gender: (json['gender'] as List)?.map((e) => e as String)?.toList(),
    updated_at: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$IgBusinessDetailsToJson(IgBusinessDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender': instance.gender,
      'age_groups': instance.age_groups,
      'category': instance.category,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };

IgCreatorDetails _$IgCreatorDetailsFromJson(Map<String, dynamic> json) {
  return IgCreatorDetails(
    id: json['id'] as String,
    updated_at: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    interests: (json['interests'] as List)?.map((e) => e as String)?.toList(),
    post_max: (json['post_max'] as num)?.toDouble(),
    post_min: (json['post_min'] as num)?.toDouble(),
    pricing_currency: json['pricing_currency'] as String,
    story_max: (json['story_max'] as num)?.toDouble(),
    story_min: (json['story_min'] as num)?.toDouble(),
    vid_max: (json['vid_max'] as num)?.toDouble(),
    vid_min: (json['vid_min'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$IgCreatorDetailsToJson(IgCreatorDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'interests': instance.interests,
      'pricing_currency': instance.pricing_currency,
      'story_min': instance.story_min,
      'story_max': instance.story_max,
      'post_min': instance.post_min,
      'post_max': instance.post_max,
      'vid_min': instance.vid_min,
      'vid_max': instance.vid_max,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
