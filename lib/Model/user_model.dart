

import 'package:academia_admin_panel/services/apiScheme.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class GetUserAuth extends ApiSchema{
  final String status;
  final String token;
  final String userId;
  final UserModel user;
  GetUserAuth(this.token,this.status,this.userId,this.user, String message, String errorCode,):super(status,message,errorCode);

  factory GetUserAuth.fromJson(Map<String, dynamic> json) => _$GetUserAuthFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserAuthToJson(this);
}

@JsonSerializable()
class UserModel {
  final String password;
  final String email;
  final String name;
  final String userType;
  UserModel({this.password, this.email,this.name,this.userType});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

