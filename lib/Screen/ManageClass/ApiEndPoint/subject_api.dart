import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Model/academic_subject_model.dart';
import 'package:academia_admin_panel/schema_pojo.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:academia_admin_panel/services/service.dart';

Future getAcademicSubjects({String classId, Map<String, String> insightQuery}) async {
  String requestUrl =  AcademicSubjectApi.academicSubjects.replaceAll('{:Id}', classId);
  return getHttpServiceFuture(requestUrl, (json) => GetSubjectModel.fromJson(json), queryParams: insightQuery,returnRaw: true);
}

Future createAcademicSubject(Map academicSubject) async {
  String requestUrl = AcademicSubjectApi.createSubject;
  return postHttpServiceFuture(requestUrl,(json) => ApiResponse.fromJson(json),postData: academicSubject,returnRaw: true);
}

Future deleteAcademicSubject(String id) async {
  String requestUrl =  AcademicSubjectApi.deleteSubject.replaceAll('{:Id}', id);

  return deleteHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),returnRaw: true
  );
}

Future updateAcademicSubjects(String id,Map updatedClass) async {
  String requestUrl =  AcademicSubjectApi.updateSubject.replaceAll('{:Id}', id);

  return patchHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),postData: updatedClass,returnRaw: true
  );
}