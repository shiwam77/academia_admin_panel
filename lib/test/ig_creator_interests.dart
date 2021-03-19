
import 'package:json_annotation/json_annotation.dart';

import 'ig_user_initiated_info.dart';

part 'ig_creator_interests.g.dart';

@JsonSerializable()
class IgCreatorInterests extends ApiSchema {

  final  IgCreatorDetails data;

  IgCreatorInterests(String status, String msg, String error_code, Map<String, dynamic> error_data, this.data,) :
        super(status, msg, error_code, error_data);

  factory IgCreatorInterests.fromJson(Map<String, dynamic> json) => _$IgCreatorInterestsFromJson(json);

  Map<String, dynamic> toJson() => _$IgCreatorInterestsToJson(this);

}

@JsonSerializable()
class IgCreatorDetails{
  final String id ;
  final String interests ;
  final String  pricing_currency ;
  final int story_min;
  final int story_max;
  final int post_min;
  final int post_max;
  final int vid_min;
  final int vid_max;
  final DateTime created_at;
  final DateTime updated_at;

  IgCreatorDetails({this.id, this.updated_at, this.created_at ,this.interests, this.post_max ,
    this.post_min, this.pricing_currency, this.story_max, this.story_min, this.vid_max, this.vid_min,});

  factory IgCreatorDetails.fromJson(Map<String, dynamic> json) => _$IgCreatorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$IgCreatorDetailsToJson(this);
}
