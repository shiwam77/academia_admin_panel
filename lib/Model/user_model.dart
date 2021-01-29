

import 'package:academia_admin_panel/services/apiScheme.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class GetUserAuth extends ApiSchema{
  final String status;
  final String token;
  final String userId;
  UserModel data;
  GetUserAuth(this.token,this.status,this.userId,this.data, String message, String errorCode,):super(status,message,errorCode);

  factory GetUserAuth.fromJson(Map<String, dynamic> json) => _$GetUserAuthFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserAuthToJson(this);
}

@JsonSerializable()
class UserModel {
  final String password;
  final String email;
  String name;
  String role;
  UserModel(this.password, this.email);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

