

import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Model/academic_hometask_model.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/endpoint.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/class_api.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_vm.dart';


class HomeTaskVm extends BaseVM {
  bool _isVmInitialised = false;
  bool isError = false;
  List<HomeTaskModel> homeTaskModel =[];


  void init(String yearId,DateTime date) async {
    if (_isVmInitialised == true) {
      return;
    }

    setState(state: ViewState.Busy);
    bool isComplete =  await fetchAcademicClass(yearId,date);
    setState(state: ViewState.Idle);

    _isVmInitialised = isComplete;
  }

  void refresh(String yearId,DateTime date){
    _isVmInitialised = false;
    init(yearId,date);
  }

  Future<bool> fetchAcademicClass(String subjectId,DateTime date) async {
    Map<String,String> insightQuery ={"date":date.toString()};
    print(insightQuery);
    try{
      if(subjectId == null){
        return false;
      }
      var response = await getAcademicHomeTasks(subjectId:subjectId,insightQuery: insightQuery);
      IgHomeTask _getClassModel = IgHomeTask.fromJson(response);
      if(_getClassModel.status == "success"){
        if(_getClassModel.data != null){
          homeTaskModel = _getClassModel.data;
          print(homeTaskModel.length);
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
      print(error);
      setErrorMessage(error.toString());
      isError = true;
      return false;
    }
  }
}