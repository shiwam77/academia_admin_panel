


import 'package:academia_admin_panel/Model/academic_subject_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/subject_api.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_vm.dart';


class ManageSubjectVm extends BaseVM{
  bool _isVmInitialised = false;
  bool isError = false;
  List<AcademicSubjectModel> academicSubjectModel =[];


  void init(String classId) async {
    if (_isVmInitialised == true) {
      return;
    }

    setState(state: ViewState.Busy);
    bool isComplete =  await fetchAcademicSubjects(classId);
    setState(state: ViewState.Idle);

    _isVmInitialised = isComplete;
  }

  void refresh(String classId){
    _isVmInitialised = false;
    init(classId);
  }

  Future<bool> fetchAcademicSubjects(String classId) async {

    try{
      if(classId == null){
        return false;
      }

      var response = await getAcademicSubjects(classId:classId);
      GetSubjectModel _getSubjectModel = GetSubjectModel.fromJson(response);
      if(_getSubjectModel.status == "success"){
        if(_getSubjectModel.data != null){
          academicSubjectModel  = _getSubjectModel.data;

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