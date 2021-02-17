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
    json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
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
      'user': instance.user,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    password: json['password'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    userType: json['role'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'password': instance.password,
      'email': instance.email,
      'name': instance.name,
      'userType': instance.userType,
    };
