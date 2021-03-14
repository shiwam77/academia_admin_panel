

import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Model/academic_hometask_model.dart';
import 'package:academia_admin_panel/Model/academic_tutor.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/endpoint.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/class_api.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_vm.dart';


class TutorVm extends BaseVM {
  bool _isVmInitialised = false;
  bool isError = false;
  List<HomeTutorModel> tutorList =[];


  void init(String classId,Map<String,String> insightQuery) async {
    if (_isVmInitialised == true) {
      return;
    }

    setState(state: ViewState.Busy);
    bool isComplete =  await fetchAcademicTutor(classId,insightQuery);
    setState(state: ViewState.Idle);

    _isVmInitialised = isComplete;
  }

  void refresh(String classId,Map<String,String> insightQuery){
    _isVmInitialised = false;
    init(classId,insightQuery);
  }

  Future<bool> fetchAcademicTutor(String classId,Map<String,String> insightQuery) async {

    print(insightQuery);
    try{
      if(classId == null){
        return false;
      }
      var response = await getAcademicTutor(classId:classId,insightQuery: insightQuery);
      IgHomeTutor _getIgTutor = IgHomeTutor.fromJson(response);
      if(_getIgTutor.status == "success"){
        if(_getIgTutor.data != null){
          tutorList = _getIgTutor.data;
          print(tutorList.length);
          return true;
        }
        return true;
      }
      else if(_getIgTutor.status == "fail"){
        String message = response["responseJson"]['message'];
        setErrorMessage(message);
        return false;
      }
      return false;
    }
    catch (error, stackTrace) {
      print(error);
      setErrorMessage(error.toString());
      isError = true;
      return false;
    }
  }
}