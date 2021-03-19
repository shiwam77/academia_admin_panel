// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ig_creator_interests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IgCreatorInterests _$IgCreatorInterestsFromJson(Map<String, dynamic> json) {
  return IgCreatorInterests(
    json['status'] as String,
    json['msg'] as String,
    json['error_code'] as String,
    json['error_data'] as Map<String, dynamic>,
    json['data'] == null
        ? null
        : IgCreatorDetails.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IgCreatorInterestsToJson(IgCreatorInterests instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'error_code': instance.error_code,
      'error_data': instance.error_data,
      'data': instance.data,
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
    interests: json['interests'] as String,
    post_max: json['post_max'] as int,
    post_min: json['post_min'] as int,
    pricing_currency: json['pricing_currency'] as String,
    story_max: json['story_max'] as int,
    story_min: json['story_min'] as int,
    vid_max: json['vid_max'] as int,
    vid_min: json['vid_min'] as int,
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
