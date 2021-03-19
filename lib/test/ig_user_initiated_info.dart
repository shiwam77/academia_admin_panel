
import 'package:json_annotation/json_annotation.dart';

import 'ig_business_category.dart';
import 'ig_creator_interests.dart';



part 'ig_user_initiated_info.g.dart';


@JsonSerializable()
class IgUserInitiatedInfo extends ApiSchema {
  final IgUser data;


  IgUserInitiatedInfo(String status, String msg, String error_code, Map<String, dynamic> error_data, this.data,) :
        super(status, msg, error_code, error_data);

  factory IgUserInitiatedInfo.fromJson(Map<String, dynamic> json) => _$IgUserInitiatedInfoFromJson(json);

  Map<String, dynamic> toJson() => _$IgUserInitiatedInfoToJson(this);

}

@JsonSerializable()
class IgUser {
   final  String uuid;
   final  String user_name;
   final String email;
   final String contact_no;
   final String profile_type;
   final bool is_active;
   final bool is_deleted;
   final IgCreatorDetails creator_details;
   final IgBusinessDetails business_details;
   final DateTime created_at;
   final DateTime updated_at;
   IgUser({ this.uuid, this.created_at, this. updated_at, this.business_details, this.contact_no,
     this.creator_details, this.email, this.is_active, this.is_deleted, this.profile_type, this.user_name});

   factory IgUser.fromJson(Map<String, dynamic> json) => _$IgUserFromJson(json);

   Map<String, dynamic> toJson() => _$IgUserToJson(this);
}


class ApiSchema {
  final String status;
  final String msg;
  final String error_code;
  final Map<String, dynamic> error_data;

  ApiSchema(this.status, this.msg, this.error_code, [this.error_data]);
}