
import 'package:json_annotation/json_annotation.dart';
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
  String uuid;
  String user_name;
  String email;
  String contact_no;
  String profile_type;
  bool is_active;
  bool is_deleted;
  DateTime created_at;
  DateTime updated_at;
  IgCreatorDetails creator_details;
  IgBusinessDetails business_details;

  IgUser({ this.user_name, this.profile_type, this.is_deleted, this.is_active, this.email, this.creator_details
    ,this.contact_no, this.business_details, this.updated_at, this.created_at, this.uuid});

  factory IgUser.fromJson(Map<String, dynamic> json) => _$IgUserFromJson(json);

  Map<String, dynamic> toJson() => _$IgUserToJson(this);

}

@JsonSerializable()
class IgBusinessDetails{
  final String  id;
  final List<String> gender;
  final List<String> age_groups;
  final String category;
  final DateTime created_at;
  final DateTime updated_at;

  IgBusinessDetails( {this.id, this.age_groups, this.category, this.created_at, this.gender, this.updated_at});

  factory IgBusinessDetails.fromJson(Map<String, dynamic> json) => _$IgBusinessDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$IgBusinessDetailsToJson(this);

}
@JsonSerializable()
class IgCreatorDetails{
  final String id ;
  final List<String> interests ;
  final String  pricing_currency ;
  final double story_min;
  final double story_max;
  final double post_min;
  final double post_max;
  final double vid_min;
  final double vid_max;
  final DateTime created_at;
  final DateTime updated_at;

  IgCreatorDetails({this.id, this.updated_at, this.created_at ,this.interests, this.post_max ,
    this.post_min, this.pricing_currency, this.story_max, this.story_min, this.vid_max, this.vid_min,});

  factory IgCreatorDetails.fromJson(Map<String, dynamic> json) => _$IgCreatorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$IgCreatorDetailsToJson(this);
}


class ApiSchema {
  final String status;
  final String msg;
  final String error_code;
  final Map<String, dynamic> error_data;

  ApiSchema(this.status, this.msg, this.error_code, [this.error_data]);
}

// "data" = {
// "user_name": "John",
// "email" : "john@gmail.com",
// "contact_no" : "+91 1234567899",
// "profile_type" : "Creator",
// "creator_details":{
// "interests" : ["gaming", "fitness", "food"],
// "pricing_currency" : "rupee",
// "story_min" : 500,
// "story_max" : 5000,
// "post_min" : 750,
// "post_max" : 7500,
// "vid_min" : 1000,
// "vid_max" : 10000,},
// "business_details":{
// "gender" : ["Male", "Female"],
// "age_groups" : ["17-19", "24-30"],
// "category" : "FoodandDrink"
// }
// }