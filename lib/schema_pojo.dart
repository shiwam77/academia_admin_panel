import 'package:academia_admin_panel/services/apiScheme.dart';
import 'package:json_annotation/json_annotation.dart';


part 'schema_pojo.g.dart';

// ignore_for_file: non_constant_identifier_names

@JsonSerializable()
class ApiResponse extends ApiSchema {

  ApiResponse(String status, String message, String errorCode,) :
        super(status, message, errorCode,);

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}