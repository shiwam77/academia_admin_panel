// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStudentModel _$GetStudentModelFromJson(Map<String, dynamic> json) {
  return GetStudentModel(
    results: json['results'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AcademicStudentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    errorCode: json['errorCode'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$GetStudentModelToJson(GetStudentModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorCode': instance.errorCode,
      'status': instance.status,
      'results': instance.results,
      'data': instance.data,
    };

AcademicStudentModel _$AcademicStudentModelFromJson(Map<String, dynamic> json) {
  return AcademicStudentModel(
    id: json['id'] as String,
    classId: json['classId'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    address: json['address'] as String,
    confirmPassword: json['confirmPassword'] as String,
    contact: json['contact'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    emailAddress: json['emailAddress'] as String,
    fatherContact: json['fatherContact'] as String,
    fatherDesignation: json['fatherDesignation'] as String,
    fatherName: json['fatherName'] as String,
    firstName: json['firstName'] as String,
    gender: json['gender'] as String,
    imageUrl: json['imageUrl'] as String,
    lastName: json['lastName'] as String,
    middleName: json['middleName'] as String,
    motherContact: json['motherContact'] as String,
    motherDesignation: json['motherDesignation'] as String,
    motherName: json['motherName'] as String,
    rollNo: json['rollNo'] as String,
      studentID:json['studentId'] as String,
    admissionNo:json['admissionNo'] as int,
    studentAsUserId:json['studentAsUserId'] as String,
  );
}

Map<String, dynamic> _$AcademicStudentModelToJson(
        AcademicStudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'rollNo': instance.rollNo,
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'motherContact': instance.motherContact,
      'fatherContact': instance.fatherContact,
      'motherDesignation': instance.motherDesignation,
      'fatherDesignation': instance.fatherDesignation,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'address': instance.address,
      'emailAddress': instance.emailAddress,
      'dateOfBirth': instance.dateOfBirth,
      'contact': instance.contact,
      'gender': instance.gender,
      'imageUrl': instance.imageUrl,
      'classId': instance.classId,
      'studentId': instance.studentID,
      'admissionNo': instance.admissionNo,
      'studentAsUserId': instance.studentAsUserId,
    };
