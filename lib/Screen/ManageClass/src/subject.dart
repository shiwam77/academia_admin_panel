import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_subject_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/subject_api.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_subject_vm.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectField extends StatefulWidget {
  @override
  _SubjectFieldState createState() => _SubjectFieldState();
}

class _SubjectFieldState extends State<SubjectField> {
  int selectedIndex;
  String classId;
  String preClassId;
  List<AcademicSubjectModel> academicSubjectModel =[];
  @override
  Widget build(BuildContext context) {
    return Consumer<ClassNotifier>(
        builder: (context,classNotifier,child){
          classId = classNotifier.getModelId();
          print("classId = $classId");
          return boxContainer(context: context,
            child: BaseView<ManageSubjectVm>(
                loaderWidget: Center(child: CircularProgressIndicator()),
                onVMReady: (ManageSubjectVm vm){
                  vm.init(classId);
                },
                builder: (_, vm, child) {
                  if(classId == preClassId){
                    if(vm.isError == false){
                      academicSubjectModel = vm.academicSubjectModel;
                      return getSubjectField(academicSubjectModel);
                    }
                    return SizedBox();
                  }
                  else{
                    preClassId = classId;
                    vm.refresh(classId);
                    return SizedBox();
                  }

                }
            ),
          );
        });
  }

  Widget getSubjectField(List<AcademicSubjectModel> listOfSubjects){
    if(listOfSubjects != null && listOfSubjects.isNotEmpty){
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: listOfSubjects.length,
            itemBuilder: (context,index){
              return LimitedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      color:selectedIndex == index?AppColors.appBackgroundColor:AppColors.transparent ,
                      height: 86,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${listOfSubjects[index].subjectName}',style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                                color: AppColors.textColorBlack
                            ),),
                            Row(children: [
                              Icon(Icons.edit,size: 30,),
                              SizedBox(width: 50,),
                              InkWell(
                                onTap: ()async{

                                  try{
                                   var response =  await deleteAcademicSubject(listOfSubjects[index].id);
                                   if(response["httpStatusCode"] == 204){
                                     setState(() {
                                       listOfSubjects.removeAt(index);
                                     });
                                   }
                                  }
                                  catch(error,stacktrace){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Something went wrong!'),
                                        ));
                                  }

                                },
                                  child: Icon(Icons.delete,size: 30,))
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    }
    return Center(child: Text("No data"),);
  }
}
