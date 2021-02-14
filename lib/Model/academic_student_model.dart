import 'package:academia_admin_panel/services/apiScheme.dart';
import 'package:json_annotation/json_annotation.dart';
part 'academic_student_model.g.dart';

@JsonSerializable()
class GetStudentModel extends ApiSchema{

  final String status;
  final int results;
  final List<AcademicStudentModel> data;
  GetStudentModel({this.results,this.data,String message, String errorCode,this.status}):super(status,message,errorCode);
  factory GetStudentModel.fromJson(Map<String, dynamic> json) => _$GetStudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetStudentModelToJson(this);
}

@JsonSerializable()
class AcademicStudentModel{
   String id;
   String firstName;
   String middleName;
   String lastName;
   String rollNo;
   String fatherName;
   String motherName;
   String motherContact;
   String fatherContact;
   String motherDesignation;
   String fatherDesignation;
   String email;
   String password;
   String confirmPassword;
   String address;
   String emailAddress;
   String dateOfBirth;
   String contact;
   String gender;
   String imageUrl;
   String classId;
  AcademicStudentModel({this.id,this.classId,this.email,this.password,this.address,this.confirmPassword,this.contact,this.dateOfBirth,this.emailAddress,this.fatherContact
  ,this.fatherDesignation,this.fatherName,this.firstName,this.gender,this.imageUrl,this.lastName,this.middleName,this.motherContact,this.motherDesignation,this.motherName
  ,this.rollNo,});

  factory AcademicStudentModel.fromJson(Map<String, dynamic> json) => _$AcademicStudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicStudentModelToJson(this);
}