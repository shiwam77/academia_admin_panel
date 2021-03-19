import 'package:json_annotation/json_annotation.dart';

import 'ig_user_initiated_info.dart';



part 'ig_business_category.g.dart';

@JsonSerializable()
class IgBusinessCategory extends ApiSchema {

  final IgBusinessDetails data;

  IgBusinessCategory(String status, String msg, String error_code, Map<String, dynamic> error_data, this.data,) :
        super(status, msg, error_code, error_data);

  factory IgBusinessCategory.fromJson(Map<String, dynamic> json) => _$IgBusinessCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$IgBusinessCategoryToJson(this);

}


@JsonSerializable()
class IgBusinessDetails{
 final String  id;
 final bool target_male;
 final bool target_female;
 final String age_groups;
 final String category;
 final DateTime created_at;
 final DateTime updated_at;

  IgBusinessDetails({ this.id, this.age_groups, this.category, this.created_at, this.target_female, this.target_male, this.updated_at,});

  factory IgBusinessDetails.fromJson(Map<String, dynamic> json) => _$IgBusinessDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$IgBusinessDetailsToJson(this);

}
