import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/schema_pojo.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:academia_admin_panel/services/service.dart';

Future getAttendance({String classId, Map<String, String> insightQuery}) async {
  String requestUrl =  AcademicAttendanceApi.academicAttendance.replaceAll('{:Id}', classId);
  return getHttpServiceFuture(requestUrl, (json) => GetClassModel.fromJson(json), queryParams: insightQuery,returnRaw: true);
}

Future createAttendance(Map academicAttendance) async {
  String requestUrl =AcademicAttendanceApi.createAttendance;
  return postHttpServiceFuture(requestUrl,(json) => ApiResponse.fromJson(json),postData: academicAttendance,returnRaw: true);
}

Future deleteAttendance(String id) async {
  String requestUrl =  AcademicAttendanceApi.deleteAttendance.replaceAll('{:Id}', id);

  return deleteHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),returnRaw: true
  );
}

Future updateAttendance(String id,Map updatedAttendance) async {
  String requestUrl =  AcademicAttendanceApi.updateAttendance.replaceAll('{:Id}', id);

  return patchHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),postData:updatedAttendance,returnRaw: true
  );
}