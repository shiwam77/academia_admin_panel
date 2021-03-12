import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Model/academic_hometask_model.dart';
import 'package:academia_admin_panel/schema_pojo.dart';
import 'package:academia_admin_panel/services/endpoint.dart';
import 'package:academia_admin_panel/services/service.dart';

Future getAcademicHomeTasks({String subjectId, Map<String, String> insightQuery}) async {
  String requestUrl =  AcademicHomeTaskApi.academicTask.replaceAll('{:Id}', subjectId);
  return getHttpServiceFuture(requestUrl, (json) =>  IgHomeTask.fromJson(json), queryParams: insightQuery,returnRaw: true);
}

Future createAcademicHomeTasks(Map academicTasks) async {
  String requestUrl = AcademicHomeTaskApi.createTask;
  return postHttpServiceFuture(requestUrl,(json) => ApiResponse.fromJson(json),postData: academicTasks,returnRaw: true);
}

Future deleteAcademicHomeTasks(String id) async {
  String requestUrl =  AcademicHomeTaskApi.deleteTask.replaceAll('{:Id}', id);

  return deleteHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),returnRaw: true
  );
}

Future updateAcademicHomeTasks(String id,Map updatedHomeTasks) async {
  String requestUrl =  AcademicHomeTaskApi.updateTask.replaceAll('{:Id}', id);

  return patchHttpServiceFuture(
      requestUrl, (json) => ApiResponse.fromJson(json),postData: updatedHomeTasks,returnRaw: true
  );
}