

import 'package:academia_admin_panel/Model/academic_year_model.dart';
import 'package:academia_admin_panel/schema_pojo.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:academia_admin_panel/services/service.dart';

Future getAcademicAllYears({String userId, Map<String, String> insightQuery}) async {
  String requestUrl =  AcademicYearApi.academicAllYear.replaceAll('{:Id}', userId);
  return getHttpServiceFuture(requestUrl, (json) => GetAcademicYear.fromJson(json), queryParams: insightQuery,returnRaw: true);
}

Future createAcademicYear(Map academicYear) async {
  String requestUrl = AcademicYearApi.createYear;
  return postHttpServiceFuture(requestUrl,(json) => ApiResponse.fromJson(json),postData: academicYear,returnRaw: true);
}

Future deleteAcademicYear(String id) async {
  String requestUrl =  AcademicYearApi.deleteYear.replaceAll('{:Id}', id);

   return deleteHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),returnRaw: true
  );
}

Future updateAcademicYear(String id,Map updatedYear) async {
  String requestUrl =  AcademicYearApi.updateYear.replaceAll('{:Id}', id);

  return patchHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),postData: updatedYear,returnRaw: true
  );
}