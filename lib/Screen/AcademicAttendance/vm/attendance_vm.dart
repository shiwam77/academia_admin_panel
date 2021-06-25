

import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/class_api.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_vm.dart';


class ManageAttendanceVm extends BaseVM{
  bool _isVmInitialised = false;
  bool isError = false;
  List<AcademicClassModel> academicClassModel =[];


  void init(String classId) async {
    if (_isVmInitialised == true) {
      return;
    }

    setState(state: ViewState.Busy);
    bool isComplete =  await fetchAttendance(classId);
    setState(state: ViewState.Idle);

    _isVmInitialised = isComplete;
  }

  void refresh(String classId){
    _isVmInitialised = false;
    init(classId);
  }

  Future<bool> fetchAttendance(String classId) async {

    try{
      if(classId == null){
        return false;
      }
      var response = await getAcademicClasses(yearId:classId);
      GetClassModel _getClassModel = GetClassModel.fromJson(response);
      if(_getClassModel.status == "success"){
        if(_getClassModel.data != null){
          academicClassModel = _getClassModel.data;
          return true;
        }
        return true;
      }
      else if(_getClassModel.status == "fail"){
        String message = response["responseJson"]['message'];
        setErrorMessage(message);
        return false;
      }
      return false;
    }
    catch (error, stackTrace) {
      setErrorMessage("Something went wrong");
      // logCrashlyticsError(error, stacktrace: stackTrace);
      // reportErrorToSentry(error, stacktrace: stackTrace);
      isError = true;
      return false;
    }
  }
}