

import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/class_api.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_vm.dart';


class ManageClassVm extends BaseVM{
  bool _isVmInitialised = false;
  bool isError = false;
  List<AcademicClassModel> academicClassModel =[];
 

  void init(String yearId) async {
    if (_isVmInitialised == true) {
      return;
    }

    setState(state: ViewState.Busy);
    bool isComplete =  await fetchAcademicClass(yearId);
    setState(state: ViewState.Idle);

    _isVmInitialised = isComplete;
  }

  void refresh(String yearId){
    _isVmInitialised = false;
    init(yearId);
  }

  Future<bool> fetchAcademicClass(String yearId) async {

    try{
    var response = await getAcademicClasses(yearId:yearId);
    GetClassModel _getClassModel = GetClassModel.fromJson(response);
    if(_getClassModel.status == "success"){
      if(_getClassModel.data != null){
        academicClassModel = _getClassModel.data;
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
        // logCrashlyticsError(error, stacktrace: stackTrace);
        // reportErrorToSentry(error, stacktrace: stackTrace);
      }
      isError = true;
      return false;
    }
  }
}