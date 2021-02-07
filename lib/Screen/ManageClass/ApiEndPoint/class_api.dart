import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/schema_pojo.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:academia_admin_panel/services/service.dart';

Future getAcademicClasses({String yearId, Map<String, String> insightQuery}) async {
  String requestUrl =  AcademicClassApi.academicClasses.replaceAll('{:Id}', yearId);
  return getHttpServiceFuture(requestUrl, (json) => GetClassModel.fromJson(json), queryParams: insightQuery,returnRaw: true);
}

Future createAcademicClass(Map academicClass) async {
  String requestUrl = AcademicClassApi.createClass;
  return postHttpServiceFuture(requestUrl,(json) => ApiResponse.fromJson(json),postData: academicClass,returnRaw: true);
}

Future deleteAcademicClass(String id) async {
  String requestUrl =  AcademicClassApi.deleteClass.replaceAll('{:Id}', id);

  return deleteHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),returnRaw: true
  );
}

Future updateAcademicClass(String id,Map updatedClass) async {
  String requestUrl =  AcademicClassApi.updateClass.replaceAll('{:Id}', id);

  return patchHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),postData: updatedClass,returnRaw: true
  );
}