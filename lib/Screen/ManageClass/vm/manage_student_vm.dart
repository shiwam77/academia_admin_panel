


import 'package:academia_admin_panel/Model/academic_student_model.dart';
import 'package:academia_admin_panel/Model/academic_subject_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/student_api.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/subject_api.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_vm.dart';


class ManageStudentVm extends BaseVM{
  bool _isVmInitialised = false;
  bool isError = false;
  List<AcademicStudentModel> academicStudentModel =[];


  void init(String classId) async {
    if (_isVmInitialised == true) {
      return;
    }

    setState(state: ViewState.Busy);
    bool isComplete =  await fetchAcademicStudents(classId);
    setState(state: ViewState.Idle);

    _isVmInitialised = isComplete;
  }

  void refresh(String classId){
    _isVmInitialised = false;
    init(classId);
  }

  Future<bool> fetchAcademicStudents(String classId) async {

    try{
      if(classId == null){
        return false;
      }

      var response = await getAcademicStudents(classId:classId);
      print(response);
      GetStudentModel _getStudentModel = GetStudentModel.fromJson(response);
      print(_getStudentModel);
      if(_getStudentModel.status == "success"){
        if(_getStudentModel.data != null){
          academicStudentModel  = _getStudentModel.data;

          return true;
        }
        return false;
      }
      return false;
    }
    catch (error, stackTrace) {
      setErrorMessage("Something went wrong");
      if (error is ApiError) {
        logger.e("Api Error: ${error.toString()}");
      } else {
        print(error);
        // logCrashlyticsError(error, stacktrace: stackTrace);
        // reportErrorToSentry(error, stacktrace: stackTrace);
      }
      isError = true;
      return false;
    }
  }
}