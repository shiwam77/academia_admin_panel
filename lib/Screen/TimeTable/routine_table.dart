import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/src/class.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_class_vm.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/material.dart';

class RoutineTable extends StatefulWidget {
  final String yearId;
  RoutineTable({Key key,this.yearId}) : super(key: key);

  @override
  _RoutineTableState createState() => _RoutineTableState();
}

class _RoutineTableState extends State<RoutineTable> {
   List<AcademicClassModel> listOfClass =[];
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30,right: 50),
          child: Row(children: [
            Text('Time Table',
              style: TextStyle(
                  fontFamily: 'ProductSans',
                  color: AppColors.indigo700,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: AppColors.white,
                  ),
                  child: classApiBuilder(),
                ),
              ),
            ),
          ],),
        ),
        SizedBox(height: 40,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 686,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(27),
            color: AppColors.appBackgroundColor,
          ),
          child: Column(
            children: [
            
              ],
          ),
        ),
      ],
    );
  }
    Widget classApiBuilder(){
    return BaseView<ManageClassVm>(
        loaderWidget: Center(child: CircularProgressIndicator()),
        onVMReady: (ManageClassVm vm){
          vm.init(widget.yearId);
        },
        builder: (_, vm, child) {
          if(vm.isError == false){
            listOfClass = vm.academicClassModel;
            return ClassListViewBuilder(listOfClass);
          }
          return SizedBox();
        }
    );
  }


}