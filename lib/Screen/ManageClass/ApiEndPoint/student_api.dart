import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Model/academic_student_model.dart';
import 'package:academia_admin_panel/Model/academic_subject_model.dart';
import 'package:academia_admin_panel/schema_pojo.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:academia_admin_panel/services/service.dart';

Future getAcademicStudents({String classId, Map<String, String> insightQuery}) async {
  String requestUrl =  AcademicStudentApi.academicStudents.replaceAll('{:Id}', classId);
  return getHttpServiceFuture(requestUrl, (json) => GetStudentModel.fromJson(json), queryParams: insightQuery,returnRaw: true);
}

Future createAcademicStudent(Map academicStudent) async {
  String requestUrl = AcademicStudentApi.createStudent;
  return postHttpServiceFuture(requestUrl,(json) => ApiResponse.fromJson(json),postData: academicStudent,returnRaw: true);
}

Future createStudentAsUser(Map academicStudent) async {
  String requestUrl = AuthApi.signUp;
  return postHttpServiceFuture(requestUrl,(json) => ApiResponse.fromJson(json),postData: academicStudent,returnRaw: true);
}

Future deleteStudentAsUser(String id) async {
  String requestUrl =  AuthApi.deleteUser.replaceAll('{:Id}', id);

  return deleteHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),returnRaw: true
  );
}

Future deleteAcademicStudent(String id) async {
  String requestUrl =  AcademicStudentApi.deleteStudent.replaceAll('{:Id}', id);

  return deleteHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),returnRaw: true
  );
}

Future updateAcademicStudent(String id,Map updatedStudent) async {
  String requestUrl =  AcademicStudentApi.updateStudent.replaceAll('{:Id}', id);

  return patchHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),postData: updatedStudent,returnRaw: true
  );
}
Future updateStudentAsUser(String id,Map updatedStudent) async {
  String requestUrl =  AuthApi.updateUser.replaceAll('{:Id}', id);

  return patchHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),postData: updatedStudent,returnRaw: true
  );
}