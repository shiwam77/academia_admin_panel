import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_subject_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/subject_api.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_subject_vm.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ClassNotifier>(
        builder: (context,classNotifier,child){
          classId = classNotifier.getModelId();
          print("classId = $classId");
          return Container(
            height: 704,
            width: MediaQuery.of(context).size.width * .39,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('Subject',
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          color: AppColors.textColorBlack,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    InkWell(
                      onTap: ()async {
                        await addSubjectInput(context);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.textColorBlack,
                            width: 2,
                          ),
                          color: AppColors.appBackgroundColor,
                        ),
                        child: Icon(Icons.add,size: 18,color: AppColors.textColorBlack,),),
                    ),
                  ],),
                ),
                boxContainer(context: context,
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
                ),
              ],
            ),
          );
        });
  }
  addSubjectInput(BuildContext context){

    TextEditingController _textEditingController = TextEditingController();
    String subject;
    return showPopupWindow(
      context,
      gravity: KumiPopupGravity.leftBottom,
      bgColor: Colors.grey.withOpacity(0.5),
      clickOutDismiss: true,
      clickBackDismiss: true,
      customAnimation: false,
      customPop: false,
      customPage: false,
      //targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
      //childSize: null,
      underStatusBar: false,
      underAppBar: true,
      offsetX: 800,
      offsetY: 575,
      duration: Duration(milliseconds: 200),
      childFun: (pop) {
        return  Container(
          key: GlobalKey(),
          padding: EdgeInsets.all(10),
          height: 180,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff707070).withOpacity(.4),
                  offset: Offset(0, 0),
                  blurRadius: 10,
                )
              ]),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child:Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.textColorBlack,
                        width: 2,
                      ),
                      color: AppColors.white,
                    ),
                    child: Icon(Icons.close,size: 15,color: AppColors.textColorBlack,),),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      child:SizedBox(
                        width:300,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: "Enter a subject name",
                            ),
                            onChanged: (value){
                              setState(() {
                                subject = value;
                              });
                            },
                            validator: (value){
                              if (value.isEmpty || value == "") {
                                return 'Please provide subject name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          color:AppColors.indigo700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                             // AcademicClassModel newClass = AcademicClassModel(className: subject,yearId: widget.yearId);
                              try{
                                //var response =  await createAcademicClass(newClass.toJson());
                                // if(response["httpStatusCode"] == 201){
                                //   String id = response["responseJson"]["data"]["id"];
                                //   newClass.id = id;
                                //   setState(() {
                                //     academicClassModel.add(newClass);
                                //   });
                                //   Navigator.of(context).pop();
                                // }
                                Navigator.of(context).pop();
                              }
                              catch(error){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Something went wrong!'),
                                    ));
                              }

                            }

                          },
                        ),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        );
      },
    );

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
