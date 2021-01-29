// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserAuth _$GetUserAuthFromJson(Map<String, dynamic> json) {
  return GetUserAuth(
    json['token'] as String,
    json['status'] as String,
    json['userId'] as String,
    json['data'] == null
        ? null
        : UserModel.fromJson(json['data'] as Map<String, dynamic>),
    json['message'] as String,
    json['errorCode'] as String,
  );
}

Map<String, dynamic> _$GetUserAuthToJson(GetUserAuth instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorCode': instance.errorCode,
      'status': instance.status,
      'token': instance.token,
      'userId': instance.userId,
      'data': instance.data,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['password'] as String,
    json['email'] as String,
  )
    ..name = json['name'] as String
    ..role = json['role'] as String;
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'password': instance.password,
      'email': instance.email,
      'name': instance.name,
      'role': instance.role,
    };
